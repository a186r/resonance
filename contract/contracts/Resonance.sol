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
    event WithdrawAllETH(address funder, uint256 ETHAmount);
    event FunderInfo(uint256[] FunderInfoArray);
    event CurrentStepFunders(address[] funderAddress, uint256[] funderTokenAmount);
    event SettlementStep(uint256 stepIndex);
    event StartNextStep(uint256 stepIndex);

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

    // 是否是组建者
    modifier isBuilder() {
        require(steps[currentStep].funder[msg.sender].isBuilder, "调用者不是组建者/裂变者，没有权限");
        _;
    }

    // 是否是募资者
    modifier isFunder() {
        require(steps[currentStep].funder[msg.sender].isFunder, "调用者不是募资者，没有权限");
        _;
    }

    // 共振还在进行中
    modifier crowdsaleIsRunning() {
        require(!crowdsaleClosed, "共振已经结束");
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
        uint256 inviteesNumber; // 我的邀请人数
        uint256 earnFormAff; // 邀请所得金额
        address promoter; // 推广人
        bool isBuilder; // 是否是组建者/裂变者（参与组建期）
        bool isFunder; // 是否是募资者（参与募资期）
        bool tokenHasWithdrawn; // Token提币完成
        bool ETHHasWithdrawn; // ETH已经提币完成
        uint256 tokenBalance; // Token余额
        uint256 ETHBalance; // ETH余额
    }

    // 组建期结构体
    struct Building{
        uint256 tokenAmount; // 组建期开放多少Token
        uint256 raisedToken; // 当前轮次已组建token数量
        uint256 personalTokenLimited;// 当前轮次每个地址最多投入多少token
        uint256 raisedTokenAmount; // 总共募资已投入多少Token
    }

    // 募资期结构体
    struct Funding{
        uint256 ETHAmount; // 募资期一共可以投入多少ETH
        uint256 raisedETH; // 募资期已经募集到的ETH数量
    }

    FissionReward fissionRewardInstance;
    FOMOReward FOMORewardInstance;
    LuckyReward luckyRewardInstance;
    FaithReward faithRewardInstance;

    // 每一轮
    struct Step{
        mapping(address => Funder) funder;// 裂变者
        address[] funders; // 当前轮次的funders
        Building building; // 当前轮次组建期
        Funding funding; // 当前轮次募资期
        uint256 upperLimit; // 金额上限
        uint256 softCap; // 软顶
        uint256 hardCap; // 硬顶
        uint256 rate; // 费率
        bool settlementFinished; // 当前轮次奖励是否结算完成
        bool stepIsClosed; // 当前轮次是否结束
    }

    uint256 public currentStep;

    Step[] steps;

    address initialFissionPerson; // 部署时设置的初始裂变者

    // 轮次mapping
    // TODO:这里考虑换成如下的方式,可以很方便的查询到每一轮次的数据，奖励那里也可以考虑使用这种方式记录
    // Step[] public steps;
    // mapping(uint256 => Step) steps;

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
        abcToken = _abcToken; // abc Token
        initialFissionPerson = _initialFissionPerson; // 初始裂变者
        beneficiary = _beneficiary; // 收款方
        openingTime = block.timestamp; // 启动时间

        // 载入奖励合约实例
        fissionRewardInstance = FissionReward(_fassionRewardAddress);
        FOMORewardInstance = FOMOReward(_FOMORewardAddress);
        luckyRewardInstance = LuckyReward(_luckyRewardAddress);
        faithRewardInstance = FaithReward(_faithRewardAddress);
    }

    /// @notice 成为裂变者，这是参与共建的第一步
    /// @param promoter 推广者
    /// @dev 在调用这个方法之前，需要用户前往Token合约调用Approve方法，获得授权
    function toBeFissionPerson(
        address promoter
    )
        public
        crowdsaleIsRunning()
        isBuildingPeriod()
    {
        require(promoter != address(0), "推广者不能是空地址");

        // 检查授权额度
        require(abcToken.allowance(msg.sender, address(this)) >= UintUtils.toWei(8),"授权额度不足");

        require(abcToken.transferFrom(msg.sender,address(this), UintUtils.toWei(8)),"转移token到合约失败");

        // 销毁3个
        abcToken.burn(UintUtils.toWei(3));

        // 5个给推广者
        abcToken.transfer(address(promoter), UintUtils.toWei(5));

        // 成为共建者
        _addBuilder(promoter);

        // 加入funder中
        steps[currentStep].funders.push(msg.sender);

        fissionRewardInstance.addAffman(currentStep, promoter, initialFissionPerson);

        emit ToBeFissionPerson(msg.sender, promoter);
    }

    // 共建（就是向合约转入token的过程）
    function jointlyBuild(
        uint256 _tokenAmount
    )
        public
        crowdsaleIsRunning()
        isBuildingPeriod()
        isBuilder()
    {
        // TODO:转入额度不能超过限额
        // require(steps[currentStep].funder[msg.sender].tokenAmount >= xiane, "共建额度已超过限额，不能继续转入");

        // 检查授权额度
        require(abcToken.allowance(msg.sender, address(this)) >= UintUtils.toWei(_tokenAmount),"授权额度不足");

        // 转入合约
        require(abcToken.transferFrom(msg.sender,address(this), UintUtils.toWei(_tokenAmount)),"转移token到合约失败");
        steps[currentStep].funder[msg.sender].tokenAmount += UintUtils.toWei(_tokenAmount);
    }

    // 募资
    // 向合约转账时会调用此方法
    function ()
        external
        payable
        crowdsaleIsRunning()
        isFundingPeriod()
    {
        uint amount = msg.value;
        steps[currentStep].funder[msg.sender].ethAmount = amount;
        steps[currentStep].funder[msg.sender].isFunder = true;
        steps[currentStep].funding.raisedETH += amount;
    }

    /// @notice 轮次结算
    /// @dev 募资期结束之后结算当前轮次的奖励和其他资金，然后进入下一轮
    /// @param _fissionWinnerList 裂变奖励获奖列表
    /// @param _LuckyWinnerList 幸运奖励获奖列表
    /// @param _FaithWinnerList 信仰奖励获奖列表
    function settlementStep(
        address[] memory _fissionWinnerList,
        address[] memory _LuckyWinnerList,
        address[] memory _FaithWinnerList
    )
        public
        onlyOwner()
        crowdsaleIsRunning()
    {
        // 判断是否当前轮次是否已经达到结算条件
        require(!crowdsaleClosed, "募资已经结束");
        // 结算奖励
        _settlementReward(_fissionWinnerList, _LuckyWinnerList, _FaithWinnerList);

        emit SettlementStep(currentStep);

        // 进入下一轮
        _startNextStep();
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

    /// @notice TODO:分配奖励
    /// @dev 每一轮次结束之后调用此方法分配奖励
    // 结算奖励，当前轮次结束之后，要结算当前轮次各奖励
    // 计算出每个奖励的用户奖金余额
    function _settlementReward(
        address[] memory _fissionWinnerList,
        address[] memory _LuckyWinnerList,
        address[] memory _FaithWinnerList
    )
        internal
        onlyOwner()
        crowdsaleIsRunning()
    {
        require(!steps[currentStep].settlementFinished, "当前轮次已经结算完毕");
        require(!steps[currentStep].stepIsClosed, "当前轮次早已经结束");

        uint256 totalFissionReward = UintUtils.toWei(steps[currentStep].funding.raisedETH.mul(20).div(100));
        uint256 totalFOMOReward = UintUtils.toWei(steps[currentStep].funding.raisedETH.mul(10).div(100));
        uint256 totalLuckyReward = UintUtils.toWei(steps[currentStep].funding.raisedETH.mul(5).div(100));
        uint256 totalFaithReward = UintUtils.toWei(steps[currentStep].funding.raisedETH.mul(5).div(100));

        // 结算裂变奖励
        // 结算其实就是两个数组，一个获奖者数组，一个奖励金额数组，提币限额放上去就可以了
        _settlementFissionReward(_fissionWinnerList, totalFissionReward);
        _settlementFOMOReward(steps[currentStep].funders, totalFOMOReward);
        _settlementLuckyReward(_LuckyWinnerList, totalLuckyReward);
        _settlementFaithReward(_FaithWinnerList, totalFaithReward);

    }

    /// 重置变量，开始下一轮
    function _startNextStep()
        internal
        crowdsaleIsRunning()
    {
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

    /// @notice funder提取自己获奖所得的所有ETH
    /// @dev 提取用户账户中所有的ETH
    function withdrawAllETH() public payable {
        require(!steps[currentStep].funder[msg.sender].ETHHasWithdrawn, "已经提币完成");

        uint256 amountOfFOMO = FOMORewardInstance.FOMORewardAmount(currentStep, msg.sender);
        uint256 amountOfLucky = luckyRewardInstance.luckyRewardAmount(currentStep, msg.sender);
        uint256 amountOfFaith = faithRewardInstance.faithRewardAmount(currentStep, msg.sender);

        steps[currentStep].funder[msg.sender].ETHBalance = amountOfFOMO.add(amountOfLucky).add(amountOfFaith);
        steps[currentStep].funder[msg.sender].ETHHasWithdrawn = true;
        msg.sender.transfer(steps[currentStep].funder[msg.sender].ETHBalance);

        emit WithdrawAllETH(msg.sender, steps[currentStep].funder[msg.sender].ETHBalance);
    }

    // 分配裂变奖励奖金
    function _settlementFissionReward(address[] memory _fissionWinnerList, uint256 _totalFissionReward) internal {
        fissionRewardInstance.dealFissionInfo(currentStep, _fissionWinnerList, _totalFissionReward);
    }

    // 分配FOMO奖励奖励金
    function _settlementFOMOReward(address[] memory _funders, uint256 _totalFOMOReward) internal {
        FOMORewardInstance.dealFOMOWinner(currentStep, _funders, _totalFOMOReward);
    }

    // 分配幸运奖励奖励金
    function _settlementLuckyReward(address[] memory _LuckyWinnerList, uint256 _totalLyckyReward) internal {
        luckyRewardInstance.dealLuckyInfo(currentStep, _LuckyWinnerList, _totalLyckyReward);
    }

    // 分配信仰奖励奖励金
    function _settlementFaithReward(address[] memory _faithWinners, uint256 _totalFaithReward) internal {
        faithRewardInstance.dealFaithWinner(currentStep, _faithWinners, _totalFaithReward);
    }

    /// @notice 提币
    function withdrawMyReward()
        public
    {
        msg.sender.transfer(0);
    }

    /// @notice 查询某轮次funders(投资者)列表和对应的投入的token列表
    function getCurrentStepFunders(uint256 _stepIndex) public {
        address[] memory funderAddress;
        uint256[] memory funderToken;

        funderAddress = steps[_stepIndex].funders;

        for(uint i = 0 ; i < funderAddress.length; i++){
            funderToken[i] = steps[_stepIndex].funder[funderAddress[i]].tokenAmount;
        }

        emit CurrentStepFunders(funderAddress, funderToken);
    }

    /// @notice 查询当前轮次组建期开放多少token，募资期已经募得的ETH
    function getCurrentStepFundsInfo()
        public
        crowdsaleIsRunning()
    {
        emit FundsInfo(steps[currentStep].building.tokenAmount, steps[currentStep].funding.raisedETH);
    }

    /// @notice 查询组建期信息
    function getBuildingPerioInfo()
        public
        crowdsaleIsRunning()
        isBuildingPeriod()
    {
        uint256 _bpCountdown;
        uint256 _remainingToken;
        uint256 _personalTokenLimited;
        uint256 _totalTokenAmount;

        _bpCountdown = (openingTime + 8 hours) - block.timestamp;
        _remainingToken = steps[currentStep].building.tokenAmount.sub(steps[currentStep].building.raisedToken);
        _personalTokenLimited = steps[currentStep].building.personalTokenLimited;
        _totalTokenAmount = steps[currentStep].building.raisedTokenAmount;
        emit BuildingPerioInfo(_bpCountdown, _remainingToken, _personalTokenLimited, _totalTokenAmount);
    }

    // 查询募资期信息
    function getFundingPeriodInfo()
        public
        crowdsaleIsRunning()
        isFundingPeriod()
    {
        uint256 _fpCountdown;
        uint256 _remainingETH;
        uint256 _rasiedETHAmount;

        _fpCountdown = (openingTime + 24) - block.timestamp;
        _remainingETH = steps[currentStep].funding.ETHAmount.sub(steps[currentStep].funding.raisedETH);
        _rasiedETHAmount = steps[currentStep].funding.raisedETH;
        emit FundingPeriodInfo(_fpCountdown, _remainingETH, _rasiedETHAmount);
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
    /// @param _stepIndex 轮次
    function getFaithRewardInfo(uint256 _stepIndex)
        public
    {
        faithRewardInstance.getFaithWinnerInfo(_stepIndex);
    }

    /// @notice 获取投资者信息（个人中心界面）
    function getFunderInfo() public {
        Funder memory funder = steps[currentStep].funder[msg.sender];

        uint256[] memory funderInfo;

        funderInfo[0] = funder.tokenBalance;
        funderInfo[1] = funder.ETHBalance;
        funderInfo[2] = funder.inviteesNumber;
        funderInfo[3] = funder.earnFormAff;
        funderInfo[4] = funder.tokenAmount;
        funderInfo[5] = funder.ethAmount;
        funderInfo[6] = luckyRewardInstance.luckyFunderTotalBalance(msg.sender);
        funderInfo[7] = fissionRewardInstance.fissionFunderTotalBalance(msg.sender);
        funderInfo[8] = FOMORewardInstance.FOMOFunderTotalBalance(msg.sender);
        funderInfo[9] = faithRewardInstance.faithFunderTotalBalance(msg.sender);

        emit FunderInfo(funderInfo);
    }

    /// @notice 添加共建者
    /// @param _promoter msg.sender的推广者
    function _addBuilder(address _promoter) internal {
        // 成为共建者
        steps[currentStep].funder[msg.sender].funderAddr = msg.sender;
        steps[currentStep].funder[msg.sender].promoter = _promoter;
        steps[currentStep].funder[msg.sender].isBuilder = true;
    }

    // 收款方
    function Beneficiary() public view returns(address payable) {
        return beneficiary;
    }

    // 转移走ETH
    function _forwardFunds() internal {
        // 只能转走全部金额的60%
        beneficiary.transfer(steps[currentStep].funding.raisedETH.mul(60).div(100));
    }

}