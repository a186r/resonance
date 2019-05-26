pragma solidity >=0.4.21 <0.6.0;

import "./UintUtils.sol";
import "./FissionReward.sol";
import "./FOMOReward.sol";
import "./LuckyReward.sol";
import "./FaithReward.sol";
import "./ABCToken.sol";

/// @title 共振全局数据管理
/// @dev 在这里处理一些全局数据
contract ResonanceDataManage{

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
    // 当前轮次
    uint256 currentStep;

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

        // TODO:这里要计算一下数额？
        // 2.消耗完资金池的总额度，共振结束
        if(fundsPool == 0) {
            crowdsaleClosed = true;
        }

        return crowdsaleClosed;
    }

    /// @notice 分配裂变奖励奖金
    function settlementFissionReward(address[] memory _fissionWinnerList, uint256 totalFissionReward)
        public
        platform()
    {
        fissionRewardInstance.dealFissionInfo(currentStep, _fissionWinnerList, totalFissionReward);
        // 在这里累加用户总余额
        for(uint i = 0; i < _fissionWinnerList.length; i++){
            ETHBalance[_fissionWinnerList[i]] += fissionRewardInstance.fissionRewardAmount(currentStep,_fissionWinnerList[i]);
        }
    }

    function settlementFOMOReward(address[] memory _funders, uint256 totalFOMOReward)
        public
        platform()
    {
        address[] memory FOMOWinnerList = FOMORewardInstance.dealFOMOWinner(currentStep, _funders, totalFOMOReward);

        for(uint i = 0; i < FOMOWinnerList.length; i++){
            ETHBalance[FOMOWinnerList[i]] += FOMORewardInstance.FOMORewardAmount(currentStep,FOMOWinnerList[i]);
        }
    }

    function settlementLuckyReward(address[] memory _LuckyWinnerList, uint256 totalLuckyReward)
        public
        platform()
    {
        luckyRewardInstance.dealLuckyInfo(currentStep, _LuckyWinnerList, totalLuckyReward);
        for(uint i = 0; i < _LuckyWinnerList.length; i++){
            ETHBalance[_LuckyWinnerList[i]] += luckyRewardInstance.luckyRewardAmount(currentStep,_LuckyWinnerList[i]);
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

    /// @notice 提取Token
    /// @dev 不要单独调用这个接口
    function withdrawTokenAmount(address _addr) public view returns (uint256) {
        return tokenBalance[_addr];
    }

    /// @notice 提取ETH
    /// @dev 请不要单独调用这个接口
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

}