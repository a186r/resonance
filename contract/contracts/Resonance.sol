pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./ABCToken.sol";
import "./UintUtils.sol";
import "./FissionReward.sol";

// TODO:所有奖励以及token转出都让用户自己提取，不要批量转账(失败和出漏洞的风险太高)
contract Resonance {

    // 事件
    // 成为裂变者
    event ToBeFissionPerson(address fissionPerson,address promoter);
    event FundsInfo(uint256 tokenAmount, uint256 raisedETH);
    event BuildingPerioInfo();
    event FundingPeriodInfo();


    // modifier
    modifier onlyAdmin(){
        require(msg.sender == admin, "只有管理员可以调用");
        _;
    }

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
        require(steps[currentStep].funders[msg.sender].isBuilder, "调用者不是组建者/裂变者，没有权限");
        _;
    }

    // 是否是募资者
    modifier isFunder() {
        require(steps[currentStep].funders[msg.sender].isFunder, "调用者不是募资者，没有权限");
        _;
    }

    // 共振还在进行中
    modifier crowdsaleRunning() {
        require(!crowdsaleClosed, "共振已经结束");
        _;
    }

    address admin;

    // 变量
    ABCToken public abcToken;

    using SafeMath for uint256;

    // 资金池剩余额度
    uint256 private fundsPool;

    // 成为裂变者需要转入的金额
    uint256 private weiMinToken = 8;

    // 收款方（每轮募集的60%转移到这个地址）
    address payable private beneficiary;

    // 开始时间
    uint256 private openingTime;

    // bool fundingSoftCapReached = false;  // 本轮次是否达到软顶目标
    // bool fundingHardCapReached = false;  // 本轮次是否达到硬顶目标
    bool crowdsaleClosed = false;   //  共振是否结束

    // 推广者 affman
    struct Affman{
        address addr;
        uint256 affIncome;
    }

    // 投资者结构体
    struct Funder{
        address funderAddr; // 地址
        uint256 tokenAmount; // 共建期打入的token数量
        uint256 ethAmount; // 募资期打入的eth数量
        address promoter; // 推广者
        bool isBuilder; // 是否是组建者/裂变者（参与组建期）
        bool isFunder; // 是否是募资者（参与募资期）
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

    // 每一轮
    struct Step{
        mapping(address => Funder) funders;// 裂变者
        mapping(address => Affman) affmans; // 推广者
        Building building; // 当前轮次组建期
        Funding funding; // 当前轮次募资期
        Affman[] affmanArray; // 当前轮次的所有推广者
        address[50] luckyMan; // 裂变奖励——获奖者数组
        uint256[50] rewardAmount; // 裂变奖励——奖金数组
        bool fissionRewardIsFinished; // 裂变奖励——是否已经结束
        uint256 upperLimit; // 金额上限
        uint256 softCap; // 软顶
        uint256 hardCap; // 硬顶
        uint256 rate; // 费率
        bool stepIsClosed; // 当前轮次是否结束
    }

    uint256 public currentStep;

    // 轮次mapping
    // TODO:这里考虑换成如下的方式,可以很方便的查询到每一轮次的数据，奖励那里也可以考虑使用这种方式记录
    // Step[] public steps;
    mapping(uint256 => Step) steps;

    // 设定相关属性
    constructor(ABCToken _abcToken, address payable _beneficiary) public {
        admin = msg.sender;
        abcToken = _abcToken; // abc Token
        beneficiary = _beneficiary; // 收款方
        openingTime = block.timestamp; // 启动时间
    }

    // 成为裂变者是加入游戏的第一步
    // 只有在共建期内才能成为裂变者并向合约转入token
    function toBeFissionPerson(
        address _promoter,
        uint256 _minAmount
    )
        public
        crowdsaleRunning()
        isBuildingPeriod()
    {
        // 是否满足裂变者要求
        require(UintUtils.toWei(_minAmount) >= UintUtils.toWei(weiMinToken),"授权额度不足");
        // 检查授权额度
        require(abcToken.allowance(msg.sender, address(this)) >= UintUtils.toWei(_minAmount),"授权额度不足");

        require(abcToken.transferFrom(msg.sender,address(this), UintUtils.toWei(weiMinToken)),"转移token到合约失败");

        // 销毁3个
        abcToken.burn(UintUtils.toWei(3));
        // 5个给推广者
        abcToken.transfer(address(_promoter), UintUtils.toWei(5));

        _addAffman(_promoter);
        _addBuilder(_promoter);

        emit ToBeFissionPerson(msg.sender,_promoter);
    }

    // 共建（就是向合约转入token的过程）
    function jointlyBuild(
        uint256 _tokenAmount
    )
        public
        crowdsaleRunning()
        isBuildingPeriod()
        isBuilder()
    {
        // 检查授权额度
        require(abcToken.allowance(msg.sender, address(this)) >= UintUtils.toWei(_tokenAmount),"授权额度不足");
        // 转入合约
        require(abcToken.transferFrom(msg.sender,address(this), UintUtils.toWei(_tokenAmount)),"转移token到合约失败");
        steps[currentStep].funders[msg.sender].tokenAmount = UintUtils.toWei(_tokenAmount);
    }

    // 募资
    // 向合约转账时会调用此方法
    function ()
        external
        payable
        crowdsaleRunning()
        isFundingPeriod()
    {
        uint amount = msg.value;
        steps[currentStep].funders[msg.sender].ethAmount = amount;
        steps[currentStep].funders[msg.sender].isFunder = true;
        steps[currentStep].funding.raisedETH += amount;
    }

    // 查询当前轮次组建期开放多少token，募资期已经募得的ETH
    function getCurrentStepFundsInfo()
        public
        crowdsaleRunning()
        returns(uint256, uint256)
    {
        emit FundsInfo(steps[currentStep].building.tokenAmount, steps[currentStep].funding.raisedETH);
        return (steps[currentStep].building.tokenAmount, steps[currentStep].funding.raisedETH);
    }

    // 查询组建期信息
    function getBuildingPerioInfo()
        public
        view
        crowdsaleRunning()
        isBuildingPeriod()
        returns(uint256, uint256, uint256, uint256)
    {
        uint256 _bpCountdown;
        uint256 _remainingToken;
        uint256 _personalTokenLimited;
        uint256 _totalTokenAmount;

        _bpCountdown = (openingTime + 8 hours) - block.timestamp;
        _remainingToken = steps[currentStep].building.tokenAmount.sub(steps[currentStep].building.raisedToken);
        _personalTokenLimited = steps[currentStep].building.personalTokenLimited;
        _totalTokenAmount = steps[currentStep].building.raisedTokenAmount;

        return (_bpCountdown, _remainingToken, _personalTokenLimited, _totalTokenAmount);
    }

    // 查询募资期信息
    function getFundingPeriodInfo()
        public
        view
        crowdsaleRunning()
        isFundingPeriod()
        returns(uint256, uint256, uint256)
    {
        uint256 _fpCountdown;
        uint256 _remainingETH;
        uint256 _rasiedETHAmount;

        _fpCountdown = (openingTime + 24) - block.timestamp;
        _remainingETH = steps[currentStep].funding.ETHAmount.sub(steps[currentStep].funding.raisedETH);
        _rasiedETHAmount = steps[currentStep].funding.raisedETH;
        return(_fpCountdown, _remainingETH, _rasiedETHAmount);
    }

    // 查询当前轮次的获奖地址列表
    // function getRewardList(uint256 _stepIndex)
    //     public
    //     view
    //     returns(address[], address[], address[], address[])
    // {

    // }

    // TODO:判断是否达到提前停止轮次的条件

    // add affman
    function _addAffman(address _promoter) internal {
        // TODO: 排除掉系统内置的地址
        require(_promoter != address(0), "");

        steps[currentStep].affmans[_promoter].affIncome += UintUtils.toWei(5);
        steps[currentStep].affmans[_promoter].addr = _promoter;

        if(steps[currentStep].affmanArray.length == 0){
            steps[currentStep].affmanArray.push(steps[currentStep].affmans[_promoter]);
        } else {
            for(uint i = 0; i < steps[currentStep].affmanArray.length; i++){
                if(steps[currentStep].affmanArray[i].addr == _promoter){
                    steps[currentStep].affmanArray[i].affIncome += 5;
                }else{
                    steps[currentStep].affmanArray.push(steps[currentStep].affmans[_promoter]);
                }
            }
        }
    }

    // add builder
    function _addBuilder(address _promoter) internal {
        steps[currentStep].funders[msg.sender].funderAddr = msg.sender;
        steps[currentStep].funders[msg.sender].promoter = _promoter;
        steps[currentStep].funders[msg.sender].isBuilder = true;
    }

    // 收款方
    function getBeneficiary() public view returns(address payable) {
        return beneficiary;
    }

    // 转移走ETH
    function _forwardFunds() internal {
        // 只能转走全部金额的60%
        beneficiary.transfer(steps[currentStep].funding.raisedETH.mul(60).div(100));
    }

    // 奖励的结算时间比较重要，当第n轮开始时，结算第n-1轮的奖励即可

    // 1.裂变奖励
    // 裂变奖励可以在当前轮次的募资期计算结果，并预分配奖励额
    // 获取裂变排序列表
    // 这一步必须在募资期完成

    // 裂变奖励
    // 新的一轮开始后再结算上一轮
    // TODO:一定要注意防止结算多次的情况
    // TODO:为了安全考虑，强制结算 currentStep-1 轮，再之前的轮次不允许结算
    function FissionReward()
        public
        onlyAdmin()
    {
        // 第一轮结束之后才能开始结算奖励
        require(currentStep >= 1, "第一轮还未结束");

        require(currentStep-1 < currentStep, "输入的轮次不正确");
        // 要结算的轮次已经结束
        require(steps[currentStep-1].stepIsClosed, "该轮次尚未结束");
        // 第 currentStep-1 轮尚未结算
        require(!steps[currentStep-1].fissionRewardIsFinished, "该轮次奖励已经发放完毕");

        // 20%的ETH用于裂变奖励
        uint256 fissionRewardAmount = UintUtils.toWei(steps[currentStep-1].funding.raisedETH).mul(20).div(100);

        // TODO:裂变奖励奖励的是前50个幸运儿，要考虑不足50个的情况
        for(uint8 i = 0; i <= steps[currentStep-1].rewardAmount.length; i++) {

            steps[currentStep-1].luckyMan[i] = (steps[currentStep-1].affmanArray[i].addr);

            if (i == 0) { //第1名奖励
                steps[currentStep-1].rewardAmount[i] = (fissionRewardAmount.mul(20).div(1000));
            } else if (i >= 1 && i <= 2) { // 第2、3名奖励
                steps[currentStep-1].rewardAmount[i] = (fissionRewardAmount.mul(15).div(1000));
            } else if (i >= 3 && i <= 5) {
                steps[currentStep-1].rewardAmount[i] = (fissionRewardAmount.mul(10).div(1000));
            } else if (i >= 6 && i <= 9) {
                steps[currentStep-1].rewardAmount[i] = (fissionRewardAmount.mul(5).div(1000));
            } else {
                steps[currentStep-1].rewardAmount[i] = (fissionRewardAmount.mul(10).div(1000).div(40));
            }
        }

        // 开始转账之前验证奖励总金额是否正确
        require(_totalRewardIsRight(currentStep-1), "奖励金额有问题，拒绝转账");

        _batchTransfer();

    }

    // 排序
    // TODO:在共建期结束的时候就应该调用这个方法排序了
    function _FissionRank()
        public
        isFundingPeriod()
    {
        require(steps[currentStep].affmanArray.length != 0, "数组为空");
        _quickSort(steps[currentStep].affmanArray, 0, steps[currentStep].affmanArray.length - 1);
    }

    // 验证该回合的奖励总金额是否正确
    function _totalRewardIsRight(uint _stepIndex) internal view returns(bool){
        // 遍历求和
        uint256 totalReward;

        for(uint i = 0;i < steps[_stepIndex].rewardAmount.length; i++){
            totalReward += steps[_stepIndex].rewardAmount[i];
        }

        return (totalReward == UintUtils.toWei(steps[_stepIndex].funding.raisedETH).mul(20).div(100));
    }

    // 分配裂变奖励的时候提供批量转账的方法
    // TODO:放弃批量转账，提供用户自行withdraw的方法
    function _batchTransfer()
        public
        payable
    {
        for(uint8 i = 0; i < steps[currentStep-1].luckyMan.length; i++){
            // 将地址转换为应付地址然后再转账
            address(uint160(steps[currentStep-1].luckyMan[i])).transfer(steps[currentStep-1].rewardAmount[i]);
        }

        // 批量转账之后将该轮次的裂变奖励设置为已结束
        steps[currentStep-1].fissionRewardIsFinished = true;
    }

    // TODO:快排
    function _quickSort(Affman[] storage arr, uint left, uint right) internal {
        uint i = left;
        uint j = right;
        uint pivot = arr[left + (right - left) / 2].affIncome;
        while (i <= j) {
            while (arr[i].affIncome < pivot) i++;
            while (pivot < arr[j].affIncome) j--;
            if (i <= j) {
                (arr[i], arr[j]) = (arr[j], arr[i]);
                i++;
                j--;
            }
        }
        if (left < j)
            _quickSort(arr, left, j);
        if (i < right)
            _quickSort(arr, i, right);
    }
    // TODO:所有的奖金应该放在轮次结算的function中去。下一轮开始前，将要分配的奖励和token全部转移走。

}