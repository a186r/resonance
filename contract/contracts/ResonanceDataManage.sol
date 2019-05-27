pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./UintUtils.sol";
import "./FissionReward.sol";
import "./FOMOReward.sol";
import "./LuckyReward.sol";
import "./FaithReward.sol";
import "./ABCToken.sol";

/// @title 共振全局数据管理
/// @dev 在这里处理一些全局数据
contract ResonanceDataManage{

    using SafeMath for uint256;

    event WhihdrawAllToken();

    mapping(address => bool) accessAllowed;

    modifier platform() {
        require(accessAllowed[msg.sender], "调用者没有调用权限");
        _;
    }

    FissionReward fissionRewardInstance;
    FOMOReward FOMORewardInstance;
    LuckyReward luckyRewardInstance;
    FaithReward faithRewardInstance;

    // 资金池剩余额度
    uint256 private fundsPool;
    // 开始时间
    uint256 private openingTime;
    // 共振是否结束
    bool crowdsaleClosed = false;
    // // 当前轮次
    // uint256 currentStep;

    // 初始Token总额度
    uint256 initBuildingTokenAmount;

    // 当前轮次组建期项目方Token额度占比
    uint8 buildingPercentOfParty = 50;

    // 当前轮次组建期社区Token额度占比
    uint8 buildingPercentOfCommunity = 50;

    // 账号可提取总余额
    mapping(address => uint256) private ETHBalance;
    mapping(address => uint256) private tokenBalance;

    constructor(
        address _fassionRewardAddress,
        address _FOMORewardAddress,
        address _luckyRewardAddress,
        address _faithRewardAddress
    ) public {
        accessAllowed[msg.sender] = true;
        // 载入奖励合约实例
        fissionRewardInstance = FissionReward(_fassionRewardAddress);
        FOMORewardInstance = FOMOReward(_FOMORewardAddress);
        luckyRewardInstance = LuckyReward(_luckyRewardAddress);
        faithRewardInstance = FaithReward(_faithRewardAddress);
    }

    // 设置第一轮参数
    function setParamForFirstStep() public platform{
        fundsPool = UintUtils.toWei(150000000);
        initBuildingTokenAmount = UintUtils.toWei(1500000);
    }

    function allowAccess(address _addr) public platform() {
        accessAllowed[_addr] = true;
    }

    function denyAccess(address _addr) public platform() {
        accessAllowed[_addr] = false;
    }

    function setFundsPool(uint256 _fundsPool) public platform() {
        fundsPool = _fundsPool;
    }

    function getFundsPool() public platform() view returns(uint256) {
        return fundsPool;
    }

    function setOpeningTime(uint256 _openingTime) public platform() {
        openingTime = _openingTime;
    }

    function getOpeningTime() public platform() view returns(uint256){
        return openingTime;
    }

    function setCrowdsaleClosed(bool _crowdsaleClosed) public platform() {
        crowdsaleClosed = _crowdsaleClosed;
    }

    function getCrowdsaleClosed() public platform() view returns(bool) {
        return crowdsaleClosed;
    }

    function getETHBalance(address _addr) public platform() view returns(uint256) {
        return ETHBalance[_addr];
    }

    function setETHBalance(address _addr, uint256 _amount) public platform() {
        ETHBalance[_addr] = _amount;
    }

    function getTokenBalance(address _addr) public platform() view returns(uint256) {
        return tokenBalance[_addr];
    }

    function setTokenBalance(address _addr, uint256 _amount) public platform() {
        tokenBalance[_addr] = _amount;
    }

    function getBuildingTokenAmount() public platform() view returns(uint256) {
        return initBuildingTokenAmount;
    }

    function setBuildingTokenAmount(uint256 _tokenAmount) public platform() {
        initBuildingTokenAmount = _tokenAmount;
    }

    // 是否是共建期
    function isBuildingPeriod() public view returns(bool){
        if(block.timestamp >= openingTime && block.timestamp < openingTime + 8 hours) {
            return true;
        }else{
            return false;
        }
    }

    // 是否是募资期
    function isFundingPeriod() public view returns(bool) {
        if(block.timestamp >= openingTime + 8 hours && block.timestamp < openingTime + 24 hours) {
            return true;
        }else{
            return false;
        }
    }

    /// @notice 判断共振是否结束
    function crowdsaleIsClosed(
        uint256 raisedETH,
        uint256 softCap
    )
        public
        returns(bool)
    {
        // 1.当前轮次募资期募资额度没有达到软顶，共振结束
        if(UintUtils.toWei(raisedETH) < UintUtils.toWei(softCap)) {
            crowdsaleClosed = true;
        }

        // 2.消耗完资金池的总额度，共振结束
        if(fundsPool == 0) {
            crowdsaleClosed = true;
        }

        return crowdsaleClosed;
    }

    /// @notice 分配裂变奖励奖金
    function settlementFissionReward(uint256 _stepIndex, address[] memory _fissionWinnerList, uint256 totalFissionReward)
        public
        platform()
    {
        fissionRewardInstance.dealFissionInfo(_stepIndex, _fissionWinnerList, totalFissionReward);
        // 在这里累加用户总余额
        for(uint i = 0; i < _fissionWinnerList.length; i++){
            ETHBalance[_fissionWinnerList[i]] += fissionRewardInstance.fissionRewardAmount(_stepIndex,_fissionWinnerList[i]);
        }
    }

    function settlementFOMOReward(uint256 _stepIndex, address[] memory _funders, uint256 totalFOMOReward)
        public
        platform()
    {
        address[] memory FOMOWinnerList = FOMORewardInstance.dealFOMOWinner(_stepIndex, _funders, totalFOMOReward);

        for(uint i = 0; i < FOMOWinnerList.length; i++){
            ETHBalance[FOMOWinnerList[i]] += FOMORewardInstance.FOMORewardAmount(_stepIndex,FOMOWinnerList[i]);
        }
    }

    function settlementLuckyReward(uint256 _stepIndex, address[] memory _LuckyWinnerList, uint256 totalLuckyReward)
        public
        platform()
    {
        luckyRewardInstance.dealLuckyInfo(_stepIndex, _LuckyWinnerList, totalLuckyReward);
        for(uint i = 0; i < _LuckyWinnerList.length; i++){
            ETHBalance[_LuckyWinnerList[i]] += luckyRewardInstance.luckyRewardAmount(_stepIndex,_LuckyWinnerList[i]);
        }
    }

    function dmSettlementFaithReward(address[] memory _faithWinners, uint256 totalFaithReward)
        public
        platform()
        returns(bool)
    {
        bool faithRewardFinished = faithRewardInstance.dealFaithWinner(_faithWinners, totalFaithReward);

        for(uint i = 0; i < _faithWinners.length; i++){
            ETHBalance[_faithWinners[i]] += faithRewardInstance.faithRewardAmount(_faithWinners[i]);
        }
        return faithRewardFinished;
    }

    /// @notice 返回可提取Token数量
    function withdrawTokenAmount(address _addr) public view returns (uint256) {
        return tokenBalance[_addr];
    }

    /// @notice 返回可提取的ETH数量
    function withdrawETHAmount(address _addr) public view returns (uint256) {
        return ETHBalance[_addr];
    }

    function emptyTokenBalance() public {
        tokenBalance[tx.origin] = 0;
    }

    function emptyETHBalance() public {
        ETHBalance[tx.origin] = 0;
    }

    /// @notice 查询当前轮次的裂变奖励获奖详情
    /// @dev 查询某轮次裂变奖励列表
    /// @param _stepIndex 轮次
    function getFissionRewardInfo(uint256 _stepIndex)
        public
        view
        returns(uint256, address[] memory, uint256[] memory)
    {
        return fissionRewardInstance.getFissionInfo(_stepIndex);
    }

    /// @notice 获取该轮次FOMO奖励详情
    /// @dev 查询某轮次FOMO奖励详情
    /// @param _stepIndex 轮次
    function getFOMORewardIofo(uint256 _stepIndex)
        public
        view
        returns(uint256, address[] memory, uint256[] memory)
    {
        return FOMORewardInstance.getFOMOWinnerInfo(_stepIndex);
    }

    /// @notice 获取该轮次幸运奖励详情
    /// @dev 查询某轮次幸运奖励获奖人列表和奖金列表
    /// @param _stepIndex 轮次
    function getLuckyRewardInfo(uint256 _stepIndex)
        public
        view
        returns(uint256, address[] memory, uint256)
    {
        return luckyRewardInstance.getLuckyInfo(_stepIndex);
    }

    /// @notice 获取信仰奖励信息
    /// @dev 查询某轮次信仰奖励获奖人列表和奖金列表
    function getFaithRewardInfo()
        public
        view
        returns(uint256, address[] memory, uint256[] memory)
    {
        return faithRewardInstance.getFaithWinnerInfo();
    }

    /// @notice 改变共振资金池共建比例
    function updateBuildingPercent(uint256 _stepIndex) public platform() returns (bool) {
        require(fundsPool > 0, "共建资金池已经消耗完毕");
        // 随着轮次推进，社区比例每轮次+1%，项目方比例每轮-1%
        if(buildingPercentOfParty < 66){
            buildingPercentOfParty += 1;
            buildingPercentOfCommunity -= 1;
        }
        require(_stepIndex >= 1, "第一轮数值已经初始化过了");
        initBuildingTokenAmount = initBuildingTokenAmount * 99 / 100 ** _stepIndex;

        return true;
    }

}