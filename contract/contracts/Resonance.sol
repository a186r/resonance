pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./ABCToken.sol";
import "./UintUtils.sol";
import "./FissionReward.sol";
import "./FOMOReward.sol";
import "./LuckyReward.sol";
import "./FaithReward.sol";

// TODO:所有奖励以及token转出都让用户自己提取，不要批量转账(失败和出漏洞的风险太高)
contract Resonance is Ownable{

    using SafeMath for uint256;

    // 事件
    // 成为裂变者
    event ToBeFissionPerson(address indexed fissionPerson, address indexed promoter);

    event FundsInfo(uint256 currentStepTokenAmount, uint256 currentStepRaisedETH);
    event BuildingPerioInfo(uint256 bpCountdown, uint256 remainingToken, uint256 personalTokenLimited, uint256 totalTokenAmount);
    event FundingPeriodInfo(uint256 fpCountdown, uint256 remainingETH, uint256 rasiedETHAmount);

    // 奖励相关事件
    event FissionRewardInfo(address[] fissionRewardList, uint256[] fissionRewardAmount);
    event FOMORewardInfo(address[] FOMORewardList, uint256[] FOMORewards);
    event LuckyRewardInfo(address[] luckyRewardList, uint256 luckyReward);
    event FaithRewardInfo(address[] faithRewardList, uint256[] faithRewardAmount);
    event WithdrawAllETH(address addr, uint256 ETHAmount);
    event WhihdrawAllToken(address from, address to, uint256 tokenAmount);
    event FunderInfo(uint256[] FunderInfoArray);
    event StepFunders(
        address[] funderAddress,
        uint256[] funderTokenAmount,
        uint256[] funderETHAmount,
        uint256[] funderInvitees,
        uint256[] funderEarnFromAff
    );
    event SettlementStep(uint256 stepIndex);

    event StartNextStep(uint256 stepIndex);

    event SetRaiseTarget(uint256 stepIndex, uint256 raiseTarget);

    event GetResonances(address[] resonances);

    event FunderTotalRaised(uint256 resonancesRasiedETH);

    // 达到软顶
    modifier softCapReached(){
        require(steps[currentStep].funding.raisedETH >= steps[currentStep].softCap, "已达到本轮软顶");
        _;
    }

    // 达到硬顶
    modifier hardCapReached(){
        require(steps[currentStep].funding.raisedETH < steps[currentStep].hardCap, "已达到本轮硬顶");
        _;
    }

    // 共建期
    modifier isBuildingPeriod() {
        require(block.timestamp >= openingTime && block.timestamp < openingTime + 8 hours, "不在共建期内");
        _;
    }

    // 募资期
    modifier isFundingPeriod() {
        require(block.timestamp >= openingTime + 8 hours && block.timestamp < openingTime + 24 hours, "不在募资期内");
        _;
    }

    // 变量
    ABCToken public abcToken;

    // 资金池剩余额度
    uint256 private fundsPool;

    // 收款方（每轮募集的60%转移到这个地址）
    address payable private beneficiary;

    // 开始时间
    uint256 private openingTime;

    bool crowdsaleClosed = false;   //  共振是否结束

    // 投资者结构体
    struct Funder{
        address funderAddr; // 地址
        uint256 tokenAmount; // 组建期已打入的token数量
        uint256 ethAmount; // 募资期已打入的eth数量
        address[] invitees; // 我的邀请人数
        uint256 earnFromAff; // 邀请所得金额
        address promoter; // 推广人
        bool isBuilder; // 是否是组建者/裂变者（参与组建期）
        bool isFunder; // 是否是募资者（参与募资期）
        bool tokenHasWithdrawn; // Token提币完成
        bool ETHHasWithdrawn; // ETH已经提币完成
    }

    // 组建期结构体
    struct Building{
        uint256 openTokenAmount; // 组建期开放多少Token
        uint256 personalTokenLimited;// 当前轮次每个地址最多投入多少token
        uint256 raisedToken; // 当前轮次已组建token数量
        uint256 raisedTokenAmount; // 总共募资已投入多少Token
    }

    // 募资期结构体
    struct Funding{
        uint256 raiseTarget; // 募资期一共可以投入多少ETH
        uint256 raisedETH; // 募资期已经募集到的ETH数量
    }

    FissionReward fissionRewardInstance;
    FOMOReward FOMORewardInstance;
    LuckyReward luckyRewardInstance;
    FaithReward faithRewardInstance;

    // // 每一轮
    struct Step{
        mapping(address => Funder) funder;// 裂变者
        address[] funders; // 当前轮次的funders
        Building building; // 当前轮次组建期
        Funding funding; // 当前轮次募资期
        uint256 softCap; // 软顶
        uint256 hardCap; // 硬顶
        uint256 rate; // 费率
        bool settlementFinished; // 当前轮次奖励是否结算完成
        bool stepIsClosed; // 当前轮次是否结束
        uint256 blockNumber; // 当前轮次结束时的区块高度
    }

    // 账号可提取总余额
    mapping(address => uint256) public ETHBalance;
    mapping(address => uint256) public tokenBalance;

    // 参与共振的地址数组
    address[] resonances;
    // 参与共振的用户募资金额
    mapping(address => uint256) resonancesRasiedETH;
    mapping(address => uint256) resonancesRasiedToken;

    uint256 currentStep;

    mapping(uint256 => Step) steps;

    address initialFissionPerson; // 部署时设置的初始裂变者

    // 设定相关属性
    /// @notice 构造函数
    /// @param _abcToken 用于共建的Token
    /// @param _beneficiary 募资后的收款方
    /// @param _initialFissionPerson 初始裂变者
    constructor(
        ABCToken _abcToken,
        address payable _beneficiary,
        address _initialFissionPerson,
        address _fassionRewardAddress,
        address _FOMORewardAddress,
        address _luckyRewardAddress,
        address _faithRewardAddress
    )
        public
    {
        // 载入奖励合约实例
        fissionRewardInstance = FissionReward(_fassionRewardAddress);
        FOMORewardInstance = FOMOReward(_FOMORewardAddress);
        luckyRewardInstance = LuckyReward(_luckyRewardAddress);
        faithRewardInstance = FaithReward(_faithRewardAddress);
        currentStep = 0;
        abcToken = _abcToken; // abc Token
        beneficiary = _beneficiary; // 收款方
        initialFissionPerson = _initialFissionPerson; // 初始裂变者
        openingTime = block.timestamp; // 启动时间
    }

    /// @notice 成为裂变者，这是参与共建的第一步
    /// @param promoter 推广者
    /// @dev 在调用这个方法之前，需要用户前往Token合约调用Approve方法，获得授权
    function toBeFissionPerson(
        address promoter
    )
        public
        isBuildingPeriod()
        returns(address, address)
    {
        require(crowdsaleIsRunning(), "共振已经结束");

        //TODO: require(steps[currentStep].funder[promoter].isBuilder,"推广者自己必须是Builder");

        require(promoter != address(0), "推广者不能是空地址");

        // 检查授权额度
        require(abcToken.allowance(msg.sender, address(this)) >= UintUtils.toWei(8),"授权额度不足");

        require(abcToken.transferFrom(msg.sender,address(this), UintUtils.toWei(8)),"转移token到合约失败");

        // 销毁3个
        abcToken.burn(UintUtils.toWei(3));

        // 5个给推广者
        abcToken.transfer(address(promoter), UintUtils.toWei(5));

        steps[currentStep].funder[promoter].earnFromAff += UintUtils.toWei(5);

        // 成为共建者
        _addBuilder(promoter);

        steps[currentStep].funder[promoter].invitees.push(msg.sender);

        fissionRewardInstance.addAffman(currentStep, promoter, initialFissionPerson);

        emit ToBeFissionPerson(msg.sender, promoter);
        return(msg.sender, promoter);
    }

    /// @notice 设置当前轮次募资目标
    /// @dev 只有在当前轮次的共建期可以由管理员设置当前轮次的募资目标
    function setRaiseTarget(
        uint256 _raiseTarget
    )
        public
        isBuildingPeriod()
        onlyOwner()
        returns(uint256, uint256)
    {
        steps[currentStep].funding.raiseTarget = _raiseTarget;
        emit SetRaiseTarget(currentStep, _raiseTarget);
        return(currentStep, _raiseTarget);
    }

    /// @notice 获取当前轮次募资目标
    function getRaiseTarget(uint256 _stepIndex) public view returns(uint256) {
        return steps[_stepIndex].funding.raiseTarget;
    }

    // 共建（就是向合约转入token的过程）
    function jointlyBuild(
        uint256 _tokenAmount
    )
        public
        isBuildingPeriod()
    {
        require(crowdsaleIsRunning(), "共振已经结束");

        // 只有builder才能参与共建
        require(isBuilder(), "调用者不是Builder");

        // 没有超过当前轮次总额
        require(steps[currentStep].building.raisedToken.add(_tokenAmount) < steps[currentStep].building.openTokenAmount, "当前轮次共建Token已经足够了");

        // 转入额度不能超过限额
        require(
            steps[currentStep].funder[msg.sender].tokenAmount.add(_tokenAmount) < steps[currentStep].building.personalTokenLimited,
            "共建额度已超过限额，不能继续转入"
        );

        // 检查授权额度
        require(abcToken.allowance(msg.sender, address(this)) >= UintUtils.toWei(_tokenAmount),"授权额度不足");

        // 转入合约
        require(abcToken.transferFrom(msg.sender,address(this), UintUtils.toWei(_tokenAmount)),"转移token到合约失败");

        steps[currentStep].funder[msg.sender].tokenAmount += UintUtils.toWei(_tokenAmount);

        // 累加用户参与共建的总额度
        resonancesRasiedToken[msg.sender] += _tokenAmount;

        // 累加token数量
        steps[currentStep].building.raisedToken += _tokenAmount;
    }

    // 募资
    // 向合约转账时会调用此方法
    function ()
        external
        payable
        isFundingPeriod()
    {
        require(crowdsaleIsRunning(), "共振已经结束");
        uint amount = msg.value;
        steps[currentStep].funder[msg.sender].ethAmount = amount;
        steps[currentStep].funder[msg.sender].isFunder = true;
        steps[currentStep].funding.raisedETH += amount;
        resonances.push(msg.sender);
        resonancesRasiedETH[msg.sender] += amount;
    }

    /// @notice 轮次结算
    /// @dev 募资期结束之后结算当前轮次的奖励和其他资金，然后进入下一轮
    /// @param _fissionWinnerList 裂变奖励获奖列表
    /// @param _LuckyWinnerList 幸运奖励获奖列表
    function settlementStep(
        address[] memory _fissionWinnerList,
        address[] memory _LuckyWinnerList
    )
        public
        onlyOwner()
        returns(bool)
    {
        // 判断是否当前轮次是否已经达到结算条件
        require(!crowdsaleClosed, "募资已经结束");
        // 结算奖励
        _settlementReward(_fissionWinnerList, _LuckyWinnerList);
        // 结算收款人余额
        ETHBalance[beneficiary] += UintUtils.toWei(steps[currentStep].funding.raisedETH.mul(60).div(100));

        emit SettlementStep(currentStep);

        if(crowdsaleClosed) {
            return true;
        }else{
            // 进入下一轮
            _startNextStep();
            return false;
        }
    }

    /// @notice 结算信仰奖励
    /// @param _FaithWinnerList 信仰奖励获奖者列表
    function settlementFaithReward(
        address[] memory _FaithWinnerList
    )
        public
        onlyOwner()
        returns(bool)
    {
        require(!crowdsaleIsRunning(), "共振还未结束");
        return _settlementFaithReward(_FaithWinnerList);
    }

    // 判断共振是否结束
    // 共振结束有两个条件
    // 1. 如果当前轮次没有达到软顶 2.共振资金池消耗完毕
    /// @dev 每一轮结算的时候调用此方法
    function _crowdsaleIsClosed()
        internal
        returns(bool)
    {
        // 1.当前轮次募资期募资额度没有达到软顶
        if(UintUtils.toWei(steps[currentStep].funding.raisedETH) < UintUtils.toWei(steps[currentStep].softCap)) {
            crowdsaleClosed = true;

            // 管理员将剩余Token提走
            _withdrawRemainingToken();
        }

        // TODO:这里要计算一下数额？
        // 2.消耗完资金池的总额度
        if(fundsPool == 0) {
            crowdsaleClosed = true;
        }

        return crowdsaleClosed;
    }

    /// @notice 管理员可以提走剩余的Token
    function _withdrawRemainingToken()
        internal
        onlyOwner()
        returns(bool)
    {
        abcToken.transfer(owner(), UintUtils.toWei(fundsPool));
    }

    /// @notice 结算裂变奖励、幸运奖励、FOMO奖励
    /// @dev 每一轮次结束之后调用此方法分配奖励
    // 结算奖励，当前轮次结束之后，要结算当前轮次各奖励
    // 计算出每个奖励的用户奖金余额
    function _settlementReward(
        address[] memory _fissionWinnerList,
        address[] memory _LuckyWinnerList
    )
        internal
        onlyOwner()
    {
        require(crowdsaleIsRunning(), "共振已经结束");
        require(!steps[currentStep].settlementFinished, "当前轮次已经结算完毕");
        require(!steps[currentStep].stepIsClosed, "当前轮次早已经结束");

        // 结算裂变奖励
        // 结算其实就是两个数组，一个获奖者数组，一个奖励金额数组，提币限额放上去就可以了
        _settlementFissionReward(_fissionWinnerList);
        _settlementFOMOReward(steps[currentStep].funders);
        _settlementLuckyReward(_LuckyWinnerList);
    }

    // TODO: 开始下一轮之前要设置共建期和募资期的一些限额等参数，还有比例

    /// 重置变量，开始下一轮
    function _startNextStep()
        internal
    {
        require(crowdsaleIsRunning(), "共振已经结束");
        // 标记当前step已经结算完成
        steps[currentStep].settlementFinished = true;
        // 标记当前轮次已经结束
        steps[currentStep].stepIsClosed = true;
        // 判断共振是否已经结束
        _crowdsaleIsClosed();
        // 进入下一轮
        currentStep++;
        emit StartNextStep(currentStep);
    }

    /// @notice 分配裂变奖励奖金
    function _settlementFissionReward(address[] memory _fissionWinnerList) internal {
        uint256 totalFissionReward = UintUtils.toWei(steps[currentStep].funding.raisedETH.mul(20).div(100));
        fissionRewardInstance.dealFissionInfo(currentStep, _fissionWinnerList, totalFissionReward);
        // 在这里累加用户总余额
        for(uint i = 0; i < _fissionWinnerList.length; i++){
            ETHBalance[_fissionWinnerList[i]] += fissionRewardInstance.fissionRewardAmount(currentStep,_fissionWinnerList[i]);
        }
    }

    /// @notice 分配FOMO奖励奖金
    function _settlementFOMOReward(address[] memory _funders) internal {
        uint256 totalFOMOReward = UintUtils.toWei(steps[currentStep].funding.raisedETH.mul(10).div(100));
        address[] memory FOMOWinnerList = FOMORewardInstance.dealFOMOWinner(currentStep, _funders, totalFOMOReward);
        // 在这里累加用户总余额
        for(uint i = 0; i < FOMOWinnerList.length; i++){
            ETHBalance[FOMOWinnerList[i]] += FOMORewardInstance.FOMORewardAmount(currentStep,FOMOWinnerList[i]);
        }
    }

    /// @notice 分配幸运奖励奖励金
    function _settlementLuckyReward(address[] memory _LuckyWinnerList) internal {
        uint256 totalLuckyReward = UintUtils.toWei(steps[currentStep].funding.raisedETH.mul(5).div(100));
        luckyRewardInstance.dealLuckyInfo(currentStep, _LuckyWinnerList, totalLuckyReward);
        // 在这里累加用户总余额
        for(uint i = 0; i < _LuckyWinnerList.length; i++){
            ETHBalance[_LuckyWinnerList[i]] += luckyRewardInstance.luckyRewardAmount(currentStep,_LuckyWinnerList[i]);
        }
    }

    // 分配信仰奖励奖励金
    function _settlementFaithReward(address[] memory _faithWinners) internal returns(bool) {
        uint256 totalFaithReward = UintUtils.toWei(steps[currentStep].funding.raisedETH.mul(5).div(100));
        bool faithRewardFinished = faithRewardInstance.dealFaithWinner(_faithWinners, totalFaithReward);
        for(uint i = 0; i < _faithWinners.length; i++){
            ETHBalance[msg.sender] += faithRewardInstance.faithRewardAmount(_faithWinners[i]);
        }

        return faithRewardFinished;
    }

    /// @notice 提token（参与募资期的用户通过这个方法提走token）
    function withdrawAllToken()
        public
        payable
        returns(address, address, uint256)
    {
        require(!steps[currentStep].funder[msg.sender].tokenHasWithdrawn, "用户在当前轮次已经提取token完成");
        uint256 withdrawAmount = tokenBalance[msg.sender];
        tokenBalance[msg.sender] = 0;
        steps[currentStep].funder[msg.sender].tokenHasWithdrawn = true;
        abcToken.transferFrom(address(this), msg.sender, withdrawAmount);
        emit WhihdrawAllToken(address(this), msg.sender, withdrawAmount);
        return(address(this), msg.sender, withdrawAmount);
    }

    /// @notice 提币(管理员或者用户都通过这个接口提走ETH)
    function withdrawAllETH()
        public
        payable
        returns(address, uint256)
    {
        require(!steps[currentStep].funder[msg.sender].ETHHasWithdrawn, "用户在当前轮次已经提币完成");
        uint256 withdrawAmount = ETHBalance[msg.sender];
        ETHBalance[msg.sender] = 0;
        steps[currentStep].funder[msg.sender].ETHHasWithdrawn = true;
        msg.sender.transfer(withdrawAmount);
        emit WithdrawAllETH(msg.sender, withdrawAmount);
        return(msg.sender, withdrawAmount);
    }

    /// @notice 查询是否是共建者
    /// @dev 如果是共建者，才可以调用jointlyBuild加入共建，如果不是共建者，则需要先调用toBeFissionPerson
    function isBuilder() public view returns(bool) {
        return steps[currentStep].funder[msg.sender].isBuilder;
    }

    /// @notice 查询是否是募资者，参与募资期
    function isFunder() public view returns(bool) {
        return steps[currentStep].funder[msg.sender].isFunder;
    }

    /// @notice 查询所有参与共振的用户的地址集合
    function getResonances()
        public
        onlyOwner()
        returns(address[] memory)
    {
        emit GetResonances(resonances);
        return(resonances);
    }

    /// @notice 查询某个用户投入ETH的总量
    function getFunderTotalRaised(address _funder) public onlyOwner() returns(uint256){
        emit FunderTotalRaised(resonancesRasiedETH[_funder]);
        return resonancesRasiedETH[_funder];
    }

    /// @notice 查询某轮次funders信息
    /// @dev 查询某轮次funders各个参数，返回各参数的数组，下标一一对应
    /// @param _stepIndex 轮次数
    function getStepFunders(uint256 _stepIndex)
        public
        onlyOwner()
        returns
    (
            address[] memory,
            uint256[] memory,
            uint256[] memory,
            uint256[] memory,
            uint256[] memory
    )
    {
        address[] memory funderAddress;
        uint256[] memory funderTokenAmount;
        uint256[] memory funderETHAmount;
        uint256[] memory funderInvitees;
        uint256[] memory earnFromAff;

        funderAddress = steps[_stepIndex].funders;

        for(uint i = 0 ; i < funderAddress.length; i++){
            funderTokenAmount[i] = steps[_stepIndex].funder[funderAddress[i]].tokenAmount;
            funderETHAmount[i] = steps[_stepIndex].funder[funderAddress[i]].ethAmount;
            funderInvitees[i] = steps[_stepIndex].funder[funderAddress[i]].invitees.length;
            earnFromAff[i] = steps[currentStep].funder[funderAddress[i]].earnFromAff;
        }

        emit StepFunders(funderAddress, funderTokenAmount, funderETHAmount, funderInvitees, earnFromAff);
        return (funderAddress, funderTokenAmount, funderETHAmount, funderInvitees, earnFromAff);
    }

    /// @notice 查询当前轮次组建期开放多少token，募资期已经募得的ETH
    function getCurrentStepFundsInfo()
        public
        returns(uint256, uint256)
    {
        require(crowdsaleIsRunning(), "共振已经结束");
        emit FundsInfo(steps[currentStep].building.openTokenAmount, steps[currentStep].funding.raisedETH);
        return(steps[currentStep].building.openTokenAmount, steps[currentStep].funding.raisedETH);
    }

    /// @notice 查询组建期信息
    function getBuildingPerioInfo()
        public
        isBuildingPeriod()
        returns(uint256, uint256, uint256, uint256)
    {
        require(crowdsaleIsRunning(), "共振已经结束");
        uint256 _bpCountdown;
        uint256 _remainingToken;
        uint256 _personalTokenLimited;
        uint256 _totalTokenAmount;

        _bpCountdown = (openingTime + 8 hours) - block.timestamp;
        _remainingToken = steps[currentStep].building.openTokenAmount.sub(steps[currentStep].building.raisedToken);
        _personalTokenLimited = steps[currentStep].building.personalTokenLimited;
        _totalTokenAmount = steps[currentStep].building.raisedTokenAmount;
        emit BuildingPerioInfo(_bpCountdown, _remainingToken, _personalTokenLimited, _totalTokenAmount);
        return(_bpCountdown, _remainingToken, _personalTokenLimited, _totalTokenAmount);
    }

    // 查询募资期信息
    function getFundingPeriodInfo()
        public
        isFundingPeriod()
        returns(uint256, uint256, uint256)
    {
        require(crowdsaleIsRunning(), "共振已经结束");
        uint256 _fpCountdown;
        uint256 _remainingETH;
        uint256 _rasiedETHAmount;

        _fpCountdown = (openingTime + 24) - block.timestamp;
        _remainingETH = steps[currentStep].funding.raiseTarget.sub(steps[currentStep].funding.raisedETH);
        _rasiedETHAmount = steps[currentStep].funding.raisedETH;
        emit FundingPeriodInfo(_fpCountdown, _remainingETH, _rasiedETHAmount);
        return(_fpCountdown, _remainingETH, _rasiedETHAmount);
    }

    /// @notice 查询当前轮次的裂变奖励获奖详情
    /// @dev 查询某轮次裂变奖励列表
    /// @param _stepIndex 轮次
    function getFissionRewardInfo(uint256 _stepIndex)
        public
    {
        fissionRewardInstance.getFissionInfo(_stepIndex);
    }

    /// @notice 获取该轮次FOMO奖励详情
    /// @dev 查询某轮次FOMO奖励详情
    /// @param _stepIndex 轮次
    function getFOMORewardIofo(uint256 _stepIndex)
        public
    {
        FOMORewardInstance.getFOMOWinnerInfo(_stepIndex);
    }

    /// @notice 获取该轮次幸运奖励详情
    /// @dev 查询某轮次幸运奖励获奖人列表和奖金列表
    /// @param _stepIndex 轮次
    function getLuckyRewardInfo(uint256 _stepIndex)
        public
    {
        luckyRewardInstance.getLuckyInfo(_stepIndex);
    }

    /// @notice 获取信仰奖励信息
    /// @dev 查询某轮次信仰奖励获奖人列表和奖金列表
    function getFaithRewardInfo()
        public
    {
        faithRewardInstance.getFaithWinnerInfo();
    }

    /// @notice 获取投资者信息（个人中心界面）
    function getFunderInfo(address _funder)
        public
        returns
    (
        uint256,
        uint256,
        uint256,
        uint256,
        uint256,
        uint256,
        uint256,
        uint256,
        uint256,
        uint256
    )

    {
        Funder memory funder = steps[currentStep].funder[_funder];

        uint256[] memory funderInfo;

        funderInfo[0] = tokenBalance[_funder];
        funderInfo[1] = ETHBalance[_funder];
        funderInfo[2] = funder.invitees.length;
        funderInfo[3] = funder.earnFromAff;
        funderInfo[4] = funder.tokenAmount;
        funderInfo[5] = funder.ethAmount;
        funderInfo[6] = luckyRewardInstance.luckyFunderTotalBalance(_funder);
        funderInfo[7] = fissionRewardInstance.fissionFunderTotalBalance(_funder);
        funderInfo[8] = FOMORewardInstance.FOMOFunderTotalBalance(_funder);
        funderInfo[9] = faithRewardInstance.faithRewardAmount(_funder);

        emit FunderInfo(funderInfo);
        return(
            funderInfo[0],
            funderInfo[1],
            funderInfo[2],
            funderInfo[3],
            funderInfo[4],
            funderInfo[5],
            funderInfo[6],
            funderInfo[7],
            funderInfo[8],
            funderInfo[9]
        );
    }

    /// @notice 添加共建者
    /// @param _promoter msg.sender的推广者
    function _addBuilder(address _promoter) internal {
        // 成为共建者
        steps[currentStep].funder[msg.sender].funderAddr = msg.sender;
        steps[currentStep].funder[msg.sender].promoter = _promoter;
        steps[currentStep].funder[msg.sender].isBuilder = true;
    }

    // /// @notice 基金会授权token额度
    // /// @dev 基金会授权一亿枚Token给合约，用于组建共振资金池
    // /// @param _approveAmount 授权数量
    // function approveTokenToContract(uint256 _approveAmount)
    //     public
    //     onlyOwner()
    // {
    //     abcToken.approve(address(this), UintUtils.toWei(_approveAmount));
    // }

    // /// @notice 基金会撤销授权

    // /// @notice 查询剩余多少授权额度
    // /// @dev 公共接口，查询剩余多少Token的剩余额度
    // function getAllowance()
    //     public
    //     view
    //     returns(uint256)
    // {
    //     return abcToken.allowance(msg.sender, address(this));
    // }


    /// @notice 共振还在进行中
    function crowdsaleIsRunning() public view returns(bool) {
        return !crowdsaleClosed;
    }

    /// @notice 返回收款方
    function Beneficiary() public view returns(address payable) {
        return beneficiary;
    }

    /// @notice 返回下一个高度的区块hash
    function getBlockHash() public view returns(bytes32 blockHash) {
        return blockhash(steps[currentStep].blockNumber.add(1));
    }

}