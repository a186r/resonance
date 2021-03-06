pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "./UintUtils.sol";
import "./FissionReward.sol";
import "./FOMOReward.sol";
import "./LuckyReward.sol";
import "./FaithReward.sol";
import "./ResonanceDataManage.sol";

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
    event WithdrawAllToken(address from, address to, uint256 tokenAmount);
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

    // 当前轮次总共已投入的ETH和Token数量
    // 已募集到的ETH数量、现在投入的ETH数量、共剩余ETH数量
    event currentStepRaisedEther(uint256 raisedETHAmount, uint256 nowRaisedEther, uint256 totalRemainingEther);
    // 已共建的Token数量、个人剩余可投入Token额度、共剩余Token额度
    event currentStepRaisedToken(uint256 raisedTokenAmount, uint256 remainingTokenForPersonal, uint256 totalRemainingToken);

    // 变量
    // ERC20
    IERC20 BDEToken;

    ResonanceDataManage resonanceDataManage;

    // 收款方（每轮募集的60%转移到这个地址）
    address payable public beneficiary;

    // 投资者结构体
    struct Funder{
        address funderAddr; // 地址
        uint256 tokenAmount; // 组建期已打入的token数量
        uint256 ethAmount; // 募资期已打入的eth数量
        address promoter; // 推广人
        bool isFunder; // 是否是募资者（参与募资期）
        bool tokenHasWithdrawn; // Token提币完成
        bool ETHHasWithdrawn; // ETH已经提币完成
    }

    mapping(address => bool) public isBuilder; //是否是共建者

    mapping(address => address[]) invitees; // 邀请人
    mapping(address => uint256) earnFromAff; // 推广所得
    mapping(address => uint256) inviteesTotalAmount; // 我的邀请人打入的eth总量
    mapping(uint256 => address[]) FOMOList; // FOMO列表

    // 组建期结构体
    struct Building{
        uint256 openTokenAmount; // 组建期开放多少Token
        uint256 personalTokenLimited;// 当前轮次每个地址最多投入多少token
        uint256 raisedToken; // 当前轮次已组建token数量
        uint256 raisedTokenAmount; // 总共募资已投入多少Token
    }

    // 募资期结构体
    struct Funding{
        uint256 raiseTarget; // 募资期一共可以投入多少ETH(募资目标)
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
        uint256 softCap; // 软顶
        uint256 hardCap; // 硬顶
        bool settlementFinished; // 当前轮次奖励是否结算完成
        bool stepIsClosed; // 当前轮次是否结束
        uint256 blockNumber; // 当前轮次结束时的区块高度
    }

    // 参与共振的地址数组
    address[] resonances;

    // 参与共振的用户募资金额
    mapping(address => uint256) resonancesRasiedETH;
    mapping(address => uint256) resonancesRasiedToken;

    uint256 public currentStep;

    mapping(uint256 => Step) steps;

    address public initialFissionPerson; // 设置的初始裂变者

    mapping(uint256 => uint256) ETHFromParty; // 基金会投入的ETH数量

    uint256 public totalETHFromParty; // 基金会募资总额

    uint256 public faithRewardTotalAmount; // 信仰奖励总奖金

    mapping(uint256 => uint256) tokenFromParty; //基金会转入的token

    mapping(uint256 => bool) public tokenTransfered; // 当前轮次基金会已经转入Token

    bool public firstParamInitialized;

    mapping (address => bool) refundIsFinished; // 用户refund是否结束

    // 设定相关属性
    /// @notice 构造函数
    /// _BDEToken 用于共建的Token
    constructor(
        IERC20 _BDEToken,
        address _resonanceDataManageAddress,
        address _fassionRewardAddress,
        address _FOMORewardAddress,
        address _luckyRewardAddress,
        address _faithRewardAddress
    )
        public
    {
        resonanceDataManage = ResonanceDataManage(_resonanceDataManageAddress);
        // 载入奖励合约实例
        fissionRewardInstance = FissionReward(_fassionRewardAddress);
        FOMORewardInstance = FOMOReward(_FOMORewardAddress);
        luckyRewardInstance = LuckyReward(_luckyRewardAddress);
        faithRewardInstance = FaithReward(_faithRewardAddress);
        currentStep = 0;
        BDEToken = _BDEToken;
    }


    /// @notice 初始化第一轮次的部分参数
    /// @dev 管理员调用这个设置对ResonanceDataManage的访问权限，并初始化第一轮的部分参数
    function initParamForFirstStep(
        address _newOwner,
        address payable _beneficiary,
        address _initialFissionPerson
    )
        public
        onlyOwner()
    {
        require(!firstParamInitialized, "第一轮次数据已经初始化过了");
        // 设置基金会收款地址
        beneficiary = _beneficiary;
        // 设置初始裂变者地址
        initialFissionPerson = _initialFissionPerson;
        resonanceDataManage.setOpeningTime(block.timestamp); // 设置启动时间
        steps[currentStep].building.openTokenAmount = UintUtils.toWei(1500000); // 第一轮Token限额
        steps[currentStep].building.personalTokenLimited = steps[currentStep].building.openTokenAmount.mul(1).div(100);
        // 设置fundsPool和initBuildingTokenAmount
        resonanceDataManage.setParamForFirstStep();
        // 初始化Token共建比例等参数
        resonanceDataManage.updateBuildingPercent(currentStep);
        firstParamInitialized = true;
        // 转移合约所有权
        transferOwnership(_newOwner);
    }

    /// @notice 成为裂变者，这是参与共建的第一步
    /// @param promoter 推广者
    /// @dev 在调用这个方法之前，需要用户前往Token合约调用Approve方法，获得授权
    function toBeFissionPerson(
        address promoter
    )
        public
        returns(address, address)
    {
        require(resonanceDataManage.isBuildingPeriod(), "不在共建期内");
        require(!resonanceDataManage.getCrowdsaleClosed(), "共振已经结束");
        require(!isBuilder[msg.sender], "裂变者不能再成为裂变者");

        if(initialFissionPerson != promoter){
            require(isBuilder[promoter],"推广者自己必须是Builder");
        }

        require(promoter != address(0), "推广者不能是空地址");

        // // 检查授权额度
        require(BDEToken.allowance(msg.sender, address(this)) >= UintUtils.toWei(8),"授权额度不足");

        require(BDEToken.transferFrom(msg.sender,address(this), UintUtils.toWei(8)),"转移token到合约失败");

        // 销毁3个
        BDEToken.transfer(address(0), UintUtils.toWei(3));

        // 5个给推广者
        BDEToken.transfer(address(promoter), UintUtils.toWei(5));

        earnFromAff[promoter] += UintUtils.toWei(5);
        // steps[currentStep].funder[promoter].earnFromAff += UintUtils.toWei(5);

        // 成为共建者
        _addBuilder(promoter);

        invitees[promoter].push(msg.sender);
        // steps[currentStep].funder[promoter].invitees.push(msg.sender);

        fissionRewardInstance.addAffman(currentStep, promoter, initialFissionPerson);

        // emit ToBeFissionPerson(msg.sender, promoter);
        return(msg.sender, promoter);
    }

    /// @notice 设置当前轮次募资目标
    /// @dev 只有在当前轮次的共建期可以由管理员设置当前轮次的募资目标
    function setRaiseTarget(
        uint256 _raiseTarget
    )
        public
        onlyOwner()
        returns(uint256, uint256)
    {
        require(resonanceDataManage.isBuildingPeriod(), "不在共建期内");
        steps[currentStep].funding.raiseTarget = _raiseTarget;
        // 当前轮次的软顶和硬顶分别赋值
        steps[currentStep].softCap = steps[currentStep].funding.raiseTarget.mul(80).div(100);
        steps[currentStep].hardCap = steps[currentStep].funding.raiseTarget;

        // emit SetRaiseTarget(currentStep, _raiseTarget);
        return(currentStep, _raiseTarget);
    }

    /// @notice 获取当前轮次募资目标
    function getRaiseTarget(uint256 _stepIndex) public view returns(uint256) {
        return steps[_stepIndex].funding.raiseTarget;
    }

    // 共建（就是向合约转入token的过程）
    function jointlyBuild(uint256 _tokenAmount) public {
        require(resonanceDataManage.isBuildingPeriod(), "不在共建期内");

        require(!resonanceDataManage.getCrowdsaleClosed(), "共振已经结束");

        // 只有builder才能参与共建
        require(isBuilder[msg.sender], "调用者不是Builder");

        // 转账数量不能超过社区可转账总额
        require(
            steps[currentStep].building.raisedToken.add(_tokenAmount) <=
            steps[currentStep].building.openTokenAmount.sub(resonanceDataManage.getBuildingTokenFromParty(currentStep)),
            "转账数量不能超过社区可转账总额"
        );

        // 转入额度不能超过个人限额
        require(
             steps[currentStep].funder[msg.sender].tokenAmount.add(_tokenAmount) <=
             steps[currentStep].building.personalTokenLimited,
            "共建额度已超过限额，不能继续转入"
        );

        // 检查授权额度
        require(BDEToken.allowance(msg.sender, address(this)) >= _tokenAmount,"授权额度不足");

        // 转入合约
        require(BDEToken.transferFrom(msg.sender, address(this), _tokenAmount),"转移token到合约失败");

        steps[currentStep].funder[msg.sender].tokenAmount += _tokenAmount;

        steps[currentStep].building.raisedTokenAmount += _tokenAmount;

        // 从资金池总额度中减去用户转入的Token数量
        resonanceDataManage.setFundsPool(resonanceDataManage.getFundsPool().sub(_tokenAmount));

        // 累加用户参与共建的总额度
        resonancesRasiedToken[msg.sender] += _tokenAmount;

        // 累加token数量
        steps[currentStep].building.raisedToken += _tokenAmount;

        emit currentStepRaisedToken(
            steps[currentStep].building.raisedToken,
            steps[currentStep].building.personalTokenLimited.sub(steps[currentStep].funder[msg.sender].tokenAmount),
            steps[currentStep].building.openTokenAmount.sub(steps[currentStep].building.raisedToken)
        );
    }

    /// @notice 共建期基金会调用此方法转入Token
    function transferToken() public payable onlyOwner() returns(bool){
        require(!tokenTransfered[currentStep], "当前轮次基金会已经转入过Token了");

        // 检查剩余的授权额度是否足够
        require(BDEToken.allowance(msg.sender, address(this)) >= resonanceDataManage.getBuildingTokenFromParty(currentStep),
            "授权额度不足"
        );

        // 转入合约
        require(BDEToken.transferFrom(msg.sender, address(this), resonanceDataManage.getBuildingTokenFromParty(currentStep)),
            "转移token到合约失败"
        );

        // 从资金池中减去基金会投入的数量
        resonanceDataManage.setFundsPool(resonanceDataManage.getFundsPool().sub(resonanceDataManage.getBuildingTokenFromParty(currentStep)));

        tokenTransfered[currentStep] = true;

        return true;
    }

    /// @notice 回调函数
    function ()
        external
        payable
    {
        require(resonanceDataManage.isFundingPeriod(), "不在募资期内");

        require(!resonanceDataManage.getCrowdsaleClosed(), "共振已经结束");

        uint amount = msg.value;

        // 投入ETH>0.1 ether
        require(amount >= 0.1 ether, "投入的ETH数量应该大于0.1 ether");

        // 转入ETH不能超出当前轮次募资目标
        require(
            msg.value.add(steps[currentStep].funding.raisedETH) <= steps[currentStep].funding.raiseTarget,
            "当前轮次已募集到足够的ETH"
        );

        // funder列表去重
        if(!steps[currentStep].funder[msg.sender].isFunder){
            steps[currentStep].funders.push(msg.sender);
        }

        // 全都加入FOMO列表
        FOMOList[currentStep].push(msg.sender);

        steps[currentStep].funder[msg.sender].ethAmount += amount;
        steps[currentStep].funder[msg.sender].isFunder = true;
        steps[currentStep].funding.raisedETH += amount;

        // 累加msg.sender的上级邀请人总花费
        inviteesTotalAmount[steps[currentStep].funder[msg.sender].promoter] += amount;

        resonances.push(msg.sender);
        resonancesRasiedETH[msg.sender] += amount;

        emit currentStepRaisedEther(
            steps[currentStep].funding.raisedETH,
            amount,
            steps[currentStep].hardCap.sub(steps[currentStep].funding.raisedETH)
        );
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
        require(beneficiary != address(0), "基金会收款地址尚未设置");

        // 共振已结束，不能结算
        if(resonanceDataManage.crowdsaleIsClosed(currentStep, steps[currentStep].funding.raisedETH, steps[currentStep].softCap)){
            return false;
        }else{
            uint256 totalTokenAmount = steps[currentStep].building.raisedToken.add(resonanceDataManage.getBuildingTokenFromParty(currentStep));

            ETHFromParty[currentStep] = steps[currentStep].funding.raisedETH
                .mul(resonanceDataManage.getBuildingTokenFromParty(currentStep))
                .mul(40)
                .div(totalTokenAmount)
                .div(100);

            // 奖励金总额的12.5%每一轮叠加，算作信仰奖励的奖励金
            faithRewardTotalAmount += ETHFromParty[currentStep].mul(125).div(1000);
            // 结算裂变奖励、FOMO奖励
            _settlementReward(_fissionWinnerList);
            // 结算幸运奖励
            _settlementLuckyReward(_LuckyWinnerList);
            // 结算基金会收款人余额
            resonanceDataManage.setETHBalance(
                currentStep,
                beneficiary,
                steps[currentStep].funding.raisedETH.mul(60).div(100) // 基金会也是每一轮提取一次
                // resonanceDataManage.getETHBalance(currentStep, beneficiary) + steps[currentStep].funding.raisedETH.mul(60).div(100)
            );

            // 进入下一轮
            _startNextStep();

            return true;
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
        require(resonanceDataManage.getCrowdsaleClosed(), "共振还未结束");
        return resonanceDataManage.dmSettlementFaithReward(
            _FaithWinnerList,
            faithRewardTotalAmount
        );
    }

    /// @notice 结算裂变奖励、FOMO奖励
    /// @dev 每一轮次结束之后调用此方法分配奖励,幸运奖励拆开结算
    function _settlementReward(
        address[] memory _fissionWinnerList
    )
        internal
    {
        require(!steps[currentStep].settlementFinished, "当前轮次已经结算完毕");
        require(!steps[currentStep].stepIsClosed, "当前轮次早已经结束");

        // 结算裂变奖励
        resonanceDataManage.settlementFissionReward(
            currentStep,
            _fissionWinnerList,
            ETHFromParty[currentStep].mul(50).div(100)
        );

        // 结算FOMO奖励
        if(FOMOList[currentStep].length > 0){
            resonanceDataManage.settlementFOMOReward(
                currentStep,
                FOMOList[currentStep],
                ETHFromParty[currentStep].mul(125).div(1000)
            );
        }else{
            return;
        }
    }

    /// @notice 结算幸运奖励
    function _settlementLuckyReward(
        address[] memory _LuckyWinnerList
    )
        internal
    {
        resonanceDataManage.settlementLuckyReward(
            currentStep,
            _LuckyWinnerList,
            ETHFromParty[currentStep].mul(25).div(100)
        );
    }

    /// 重置变量，开始下一轮
    function _startNextStep()
        internal
    {
        // 标记当前step已经结算完成
        steps[currentStep].settlementFinished = true;
        // 标记当前轮次已经结束
        steps[currentStep].stepIsClosed = true;

        // 进入下一轮
        currentStep++;
        // 下一轮开始计时
        resonanceDataManage.setOpeningTime(block.timestamp);
        // 初始化Token共建比例等参数
        resonanceDataManage.updateBuildingPercent(currentStep);
        // 初始Token总额度
        steps[currentStep].building.openTokenAmount = resonanceDataManage.getBuildingTokenAmount();
        // 设置本轮个人限额
        steps[currentStep].building.personalTokenLimited = steps[currentStep].building.openTokenAmount.mul(1).div(100);
    }

    /// @notice 提token（参与募资期的用户通过这个方法提走token）
    function withdrawAllToken()
        public
        payable
        returns(address, address, uint256)
    {
        require(currentStep != 0, "请等待下一轮次再来提取第一轮的token");

        // 本轮提取上一轮的
        uint256 withdrawStep = currentStep.sub(1);

        require(steps[withdrawStep].funder[msg.sender].isFunder, "用户没有参与上一轮次的募资期");

        require(!steps[withdrawStep].funder[msg.sender].tokenHasWithdrawn, "用户已经提取token完成");

        require(steps[withdrawStep].funder[msg.sender].ethAmount > 0, "用户在上一轮次没有参与组建期Token投币");

        require(steps[withdrawStep].funding.raisedETH > 0, "上一轮次募资期募集到0个ETH");

        // 计算用户应提取Token数量
        // 应提取数量 = 共建期募集到的Token数量 * 募资期用户投入ETH数量 / 已募集到的ETH数量
        uint256 totalTokenAmountPriv = steps[withdrawStep].building.raisedToken
            .add(resonanceDataManage.getBuildingTokenFromParty(withdrawStep));

        uint256 withdrawAmount = totalTokenAmountPriv.
            mul(steps[withdrawStep].funder[msg.sender].ethAmount).
            div(steps[withdrawStep].funding.raisedETH);

        resonanceDataManage.emptyTokenBalance(withdrawStep, msg.sender);
        steps[withdrawStep].funder[msg.sender].tokenHasWithdrawn = true;
        BDEToken.transfer(msg.sender, withdrawAmount);

        return(address(this), msg.sender, withdrawAmount);
    }

    /// @notice 提币(管理员或者用户都通过这个接口提走ETH)
    function withdrawAllETH()
        public
        payable
        returns(address, uint256)
    {
        require(currentStep != 0, "请等待下一轮次再来提取第一轮的ether");

        // 本轮提取上一轮的
        uint256 withdrawStep = currentStep.sub(1);

        address payable dest = address(uint160(msg.sender));

        require(!steps[withdrawStep].funder[msg.sender].ETHHasWithdrawn, "用户在当前轮次已经提取ETH完成");

        uint256 withdrawAmount;

        // 如果是基金会地址，不用计算，直接提走60%
        if(msg.sender == beneficiary){
            withdrawAmount = resonanceDataManage.withdrawETHAmount(withdrawStep, msg.sender);
        }else{// 如果是社区地址，需要计算共建期token换得的eth数量
            withdrawAmount = _calculationWithdrawETHAmount(withdrawStep);
        }

        // 将上一轮奖励所得清空
        resonanceDataManage.emptyETHBalance(withdrawStep, msg.sender);

        steps[withdrawStep].funder[msg.sender].ETHHasWithdrawn = true;

        dest.transfer(withdrawAmount);

        return(msg.sender, withdrawAmount);
    }


    /// @notice 提取信仰奖励和最后一轮次的退款
    function withdrawFaithRewardAndRefund() public payable returns(bool){
        // 共振结束后才可以提取
        require(resonanceDataManage.getCrowdsaleClosed(), "共振还未结束，不能提取");

        require(!refundIsFinished[msg.sender], "退款已经提取完成了");
        address payable dest = address(uint160(msg.sender));

        uint256 resonanceClosedStep = resonanceDataManage.getResonanceClosedStep();
        uint256 withdrawTokenAmount;

        // 用户可提取的ETH数量
        uint256 withdrawETHAmount = steps[resonanceClosedStep].funder[msg.sender].ethAmount
            .add(resonanceDataManage.getFaithRewardBalance(msg.sender));

        // 用户可提取的Token数量
        if(msg.sender == beneficiary){
            withdrawTokenAmount = resonanceDataManage.getBuildingTokenFromParty(resonanceClosedStep);
        }else{
            withdrawTokenAmount = steps[resonanceClosedStep].funder[msg.sender].tokenAmount;
        }

        // 置空
        steps[resonanceClosedStep].funder[msg.sender].ethAmount = 0;
        resonanceDataManage.setFaithRewardBalance(msg.sender, 0);

        // 提取
        BDEToken.transfer(msg.sender, withdrawTokenAmount);
        dest.transfer(withdrawETHAmount);

        refundIsFinished[msg.sender] = true;
        return refundIsFinished[msg.sender];
    }

    /// @notice 管理员可以提走合约内所有的ETH
    /// @dev 防止ETH被锁死在合约内
    function withdrawAllETHByOwner()
        public
        payable
        onlyOwner()
    {
        beneficiary.transfer(address(this).balance);
        BDEToken.transfer(msg.sender, BDEToken.balanceOf(address(this)));
    }

    /// @notice 查询是否是募资者，参与募资期
    function isFunder() public view returns(bool) {
        return steps[currentStep].funder[msg.sender].isFunder;
    }

    /// @notice 查询某轮次msg.sender是否是funder
    function isFunderByStep(uint256 _stepIndex) public view returns(bool){
        return steps[_stepIndex].funder[msg.sender].isFunder;
    }

    /// @notice 查询funder的邀请人集合
    function getInvitees(address _funder) public view returns(address[] memory) {
        return invitees[_funder];
        // return steps[currentStep].funder[_funder].invitees;
    }

    /// @notice 查询所有参与共振的用户的地址集合
    function getResonances()
        public
        view
        onlyOwner()
        returns(address[] memory)
    {
        // emit GetResonances(resonances);
        return(resonances);
    }

    /// @notice 查询某个用户投入ETH的总量
    function getFunderTotalRaised(address _funder) public view onlyOwner() returns(uint256){
        // emit FunderTotalRaised(resonancesRasiedETH[_funder]);
        return resonancesRasiedETH[_funder];
    }

    /// @notice 查询某轮次funders信息
    /// @dev 查询某轮次funders各个参数，返回各参数的数组，下标一一对应
    /// @param _stepIndex 轮次数
    function getStepFunders(uint256 _stepIndex)
        public
        view
        onlyOwner()
        returns
    (
        address[] memory,
        uint256[] memory,
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
        uint256[] memory _earnFromAff;
        uint256[] memory _inviteesTotalAmount;

        funderAddress = new address[](steps[_stepIndex].funders.length);
        funderTokenAmount = new uint256[](funderAddress.length);
        funderETHAmount = new uint256[](funderAddress.length);
        funderInvitees = new uint256[](funderAddress.length);
        _earnFromAff = new uint256[](funderAddress.length);
        _inviteesTotalAmount = new uint256[](funderAddress.length);

        funderAddress = steps[_stepIndex].funders;

        for(uint i = 0 ; i < funderAddress.length; i++){
            funderTokenAmount[i] = steps[_stepIndex].funder[funderAddress[i]].tokenAmount;
            funderETHAmount[i] = steps[_stepIndex].funder[funderAddress[i]].ethAmount;
            funderInvitees[i] = invitees[funderAddress[i]].length;
            _earnFromAff[i] = earnFromAff[funderAddress[i]];
            _inviteesTotalAmount[i] = inviteesTotalAmount[funderAddress[i]];
        }

        return (funderAddress, funderTokenAmount, funderETHAmount, funderInvitees, _earnFromAff, _inviteesTotalAmount);
    }

    /// @notice 查询当前轮次组建期开放多少token，募资期已经募得的ETH
    function getCurrentStepFundsInfo()
        public
        view
        returns(uint256, uint256, uint256)
    {
        return(currentStep, steps[currentStep].building.openTokenAmount, steps[currentStep].funding.raisedETH);
    }

    /// @notice 获取上一轮可提取的Token和ETH数量
    function getWithdrawAmountPriv() public view returns(uint256, uint256) {
        require(currentStep != 0, "下一轮再来查看第一轮的数据");

        uint256 _withdrawTokenAmount;
        uint256 _withdrawETHAmount;
        uint256 withdrawStep = currentStep.sub(1);

        if(steps[withdrawStep].funder[msg.sender].tokenHasWithdrawn){
            _withdrawTokenAmount = 0;
        }else{
            _withdrawTokenAmount = _calculationWithdrawTokenAmount(withdrawStep);
        }

        if(steps[withdrawStep].funder[msg.sender].ETHHasWithdrawn){
            _withdrawETHAmount = 0;
        }else{
            _withdrawETHAmount = _calculationWithdrawETHAmount(withdrawStep);
        }

        return(
            _withdrawTokenAmount,
            _withdrawETHAmount
        );
    }

    /// @notice 查询组建期信息
    function getBuildingPerioInfo()
        public
        view
        returns(uint256, uint256, uint256, uint256)
    {
        uint256 _bpCountdown;
        uint256 _remainingToken;
        uint256 _personalTokenLimited;
        uint256 _totalTokenAmount;

        // 共建期结束，返回0
        if(resonanceDataManage.getOpeningTime().add(8 hours) <= block.timestamp){
            _bpCountdown = 0;
        }else{
            _bpCountdown = (resonanceDataManage.getOpeningTime().add(8 hours)).sub(block.timestamp);
        }
        _remainingToken = steps[currentStep].building.openTokenAmount.
            sub(steps[currentStep].building.raisedToken).
            sub(resonanceDataManage.getBuildingTokenFromParty(currentStep));

        _personalTokenLimited = steps[currentStep].building.personalTokenLimited;
        _totalTokenAmount = steps[currentStep].building.raisedTokenAmount;

        return(_bpCountdown, _remainingToken, _personalTokenLimited, _totalTokenAmount);
    }

    // 查询募资期信息
    function getFundingPeriodInfo()
        public
        view
        returns(uint256, uint256, uint256)
    {
        uint256 _fpCountdown;
        uint256 _remainingETH;
        uint256 _rasiedETHAmount;

        // 募资期结束，返回0
        if(resonanceDataManage.getOpeningTime().add(24 hours) <= block.timestamp){
            _fpCountdown = 0;
        }else{
            _fpCountdown = (resonanceDataManage.getOpeningTime().add(24 hours)).sub(block.timestamp);
        }
        _remainingETH = steps[currentStep].funding.raiseTarget.sub(steps[currentStep].funding.raisedETH);
        _rasiedETHAmount = steps[currentStep].funding.raisedETH;

        return(_fpCountdown, _remainingETH, _rasiedETHAmount);
    }

    /// @notice 计算用户可提取Token数量(通过赚取的)
    function _calculationWithdrawTokenAmount(uint256 _stepIndex) internal view returns(uint256){

        uint256 _withdrawTokenAmount;

        uint256  currentStepTotalRaisedToken = steps[_stepIndex].building.raisedToken
            .add(resonanceDataManage.getBuildingTokenFromParty(_stepIndex));

        _withdrawTokenAmount = currentStepTotalRaisedToken.
            mul(steps[_stepIndex].funder[msg.sender].ethAmount).
            div(steps[_stepIndex].funding.raisedETH);

        return _withdrawTokenAmount;
    }

    /// @notice 计算用户可提取的ETH数量(通过赚取的)
    function _calculationWithdrawETHAmount(uint256 _stepIndex) internal view returns(uint256){
        uint256 _withdrawETHAmount;

        uint256 totalTokenAmount = steps[_stepIndex].building.raisedToken
            .add(resonanceDataManage.getBuildingTokenFromParty(_stepIndex));

        _withdrawETHAmount = steps[_stepIndex].funder[msg.sender].tokenAmount
            .mul(steps[_stepIndex].funding.raisedETH)
            .div(totalTokenAmount);

        return _withdrawETHAmount.add(resonanceDataManage.withdrawETHAmount(_stepIndex, msg.sender));
    }

    /// @notice 获取用户获奖信息
    function getFunderRewardInfo() public view returns(uint256, uint256, uint256, uint256) {
        return(
            luckyRewardInstance.luckyFunderTotalBalance(msg.sender),
            fissionRewardInstance.fissionFunderTotalBalance(msg.sender),
            FOMORewardInstance.FOMOFunderTotalBalance(msg.sender),
            faithRewardInstance.faithRewardAmount(msg.sender)
        );
    }

    /// @notice 获取用户推广信息信息
    function getFunderAffInfo() public view returns(uint256, uint256) {
        return(
            invitees[msg.sender].length, // 我的邀请人数
            earnFromAff[msg.sender] // 推广所得
        );
    }

    // 获取用户可提取Token数量
    function getFunderWithdrawTokenAmount(uint256 _stepIndex) public view returns(uint256) {
        require(_stepIndex <= currentStep, "stepIndex不存在");
        return _calculationWithdrawTokenAmount(_stepIndex);
    }

    // 获取用户可提取ETH数量
    function getFunderWithdrawETHAmount(uint256 _stepIndex) public view returns(uint256) {
        require(_stepIndex <= currentStep, "stepIndex不存在");
        return _calculationWithdrawETHAmount(_stepIndex);
    }

    // 获取用户组建期已打入token数量
    function getFunderTokenAmount(uint256 _stepIndex) public view returns(uint256) {
        require(_stepIndex <= currentStep, "stepIndex不存在");

        return steps[_stepIndex].funder[msg.sender].tokenAmount;
    }

    // 获取用户募资期已打入eth数量
    function getFunderETHAmount(uint256 _stepIndex) public view returns(uint256) {
        require(_stepIndex <= currentStep, "stepIndex不存在");

        return steps[_stepIndex].funder[msg.sender].ethAmount;
    }

    /// @notice 添加共建者
    /// @param _promoter msg.sender的推广者
    function _addBuilder(address _promoter) internal {
        // 成为共建者
        steps[currentStep].funder[msg.sender].funderAddr = msg.sender;
        steps[currentStep].funder[msg.sender].promoter = _promoter;
        isBuilder[msg.sender] = true;
    }

    /// @notice 返回区块hash
    function getBlockHash(uint256 _stepIndex) public view returns(bytes32) {
        return blockhash(steps[_stepIndex].blockNumber+1);
    }

    /// @notice 设置当前轮次的区块高度
    function setBlockHash(uint256 _stepIndex) public returns(bool) {
        if(steps[_stepIndex].blockNumber == 0){
            steps[_stepIndex].blockNumber = block.number;
            return true;
        }else{
            return false;
        }
    }

    /// @notice 查询轮次是否结束
    function currentStepIsClosed(uint256 _stepIndex) public view returns(bool) {
        return steps[_stepIndex].stepIsClosed;
    }
}