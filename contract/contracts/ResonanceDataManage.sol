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

    event AllowAccess(address indexed);

    // 地址是否有访问权限
    mapping(address => bool) public accessAllowed;

    modifier platform() {
        require(accessAllowed[msg.sender], "调用者没有调用权限");
        _;
    }

    FissionReward fissionRewardInstance;
    FOMOReward FOMORewardInstance;
    LuckyReward luckyRewardInstance;
    FaithReward faithRewardInstance;

    // 资金池剩余额度
    uint256 public fundsPool;
    // 开始时间
    uint256 public openingTime;
    // 共振是否结束
    bool crowdsaleClosed;

    // 共振结束时的Step
    uint256 resonanceClosedStep;

    // 初始Token总额度
    uint256 initBuildingTokenAmount;

    // 当前轮次组建期项目方Token额度占比
    uint256 buildingPercentOfParty = 50;

    // 当前轮次组建期基金会投入的Token数量；
    // uint256 buildingTokenFromParty;
    mapping(uint256 => uint256) buildingTokenFromParty;

    // 当前轮次组建期社区Token额度占比
    uint256 buildingPercentOfCommunity = 50;

    uint256 personalTokenLimited;// 当前轮次每个地址最多投入多少token

    // step => address => 可提取ether
    mapping(uint256 => mapping(address => uint256)) private ETHBalance;
    // step => address => 可提取token
    mapping(uint256 => mapping(address => uint256)) private tokenBalance;

    mapping(uint256 => mapping(address => uint256)) FissionBalance;
    mapping(uint256 => mapping(address => uint256)) FOMOBalance;
    mapping(uint256 => mapping(address => uint256)) LuckyBalance;

    // 用户信仰奖励余额
    mapping(address => uint256) private faithRewardBalance;

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
    function setParamForFirstStep() public platform() {
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

    function getFundsPool() public view returns(uint256) {
        return fundsPool;
    }

    function setOpeningTime(uint256 _openingTime) public platform() {
        openingTime = _openingTime;
    }

    /// @notice 当前轮次的开始时间
    function getOpeningTime() public view returns(uint256){
        return openingTime;
    }

    function setCrowdsaleClosed(bool _crowdsaleClosed) public platform() {
        crowdsaleClosed = _crowdsaleClosed;
    }

    function getCrowdsaleClosed() public view returns(bool) {
        return crowdsaleClosed;
    }

    function getETHBalance(uint256 _stepIndex, address _addr) public view returns(uint256) {
        return ETHBalance[_stepIndex][_addr];
    }

    function setETHBalance(uint256 _stepIndex, address _addr, uint256 _amount) public platform() {
        ETHBalance[_stepIndex][_addr] = _amount;
    }

    function getTokenBalance(uint256 _stepIndex, address _addr) public view returns(uint256) {
        return tokenBalance[_stepIndex][_addr];
    }

    function setTokenBalance(uint256 _stepIndex, address _addr, uint256 _amount) public platform() {
        tokenBalance[_stepIndex][_addr] = _amount;
    }

    function getBuildingTokenAmount() public view returns(uint256) {
        return initBuildingTokenAmount;
    }

    // 是否是共建期
    function isBuildingPeriod() public view returns(bool){
        // if(block.timestamp >= openingTime && block.timestamp < openingTime.add(8 hours)) {
        // if(block.timestamp >= openingTime && block.timestamp <= openingTime.add(15 minutes)) {
        //     return true;
        // }else{
        //     return false;
        // }
        return true;
    }

    // 是否是募资期
    function isFundingPeriod() public view returns(bool) {
        // if(block.timestamp >= openingTime.add(8 hours) && block.timestamp < openingTime.add(24 hours)) {
        // if(block.timestamp >= openingTime.add(15 minutes) && block.timestamp <= openingTime.add(30 minutes)) {
        //     return true;
        // }else{
        //     return false;
        // }
        return true;
    }

    /// @notice 判断共振是否结束
    /// @dev 根据共振结束条件判断共振是否结束，修改变量
    /// @param raisedETH 募资期已经募集的ETH数量
    /// @param softCap 当前轮次软顶
    function crowdsaleIsClosed(
        uint256 stepIndex,
        uint256 raisedETH,
        uint256 softCap
    )
        public
        platform()
        returns(bool)
    {
        // 1.当前轮次募资期募资额度没有达到软顶，共振结束
        if(raisedETH < softCap) {
            resonanceClosedStep = stepIndex;
            setCrowdsaleClosed(true);
        }else{
            setCrowdsaleClosed(false);
            // 2.消耗完资金池的总额度，共振结束
            if(fundsPool == 0) {
                resonanceClosedStep = stepIndex;
                setCrowdsaleClosed(true);
            }else{
                setCrowdsaleClosed(false);
            }
        }

        return getResonanceIsClosed();
    }

    /// @notice 查询共振结束时的轮次Index
    function getResonanceClosedStep() public view returns(uint256){
        return resonanceClosedStep;
    }

    /// @notice 查询共振是否结束
    function getResonanceIsClosed() public view returns(bool) {
        return crowdsaleClosed;
    }

    /// @notice 分配裂变奖励奖金
    function settlementFissionReward(uint256 _stepIndex, address[] memory _fissionWinnerList, uint256 totalFissionReward)
        public
        platform()
    {
        fissionRewardInstance.dealFissionInfo(_stepIndex, _fissionWinnerList, totalFissionReward);
        // 在这里累加用户可提取余额
        for(uint i = 0; i < _fissionWinnerList.length; i++){
            FissionBalance[_stepIndex][_fissionWinnerList[i]] = fissionRewardInstance.fissionRewardAmount(_stepIndex,_fissionWinnerList[i]);
        }
    }

    /// @notice 分配FOMO奖励奖金
    function settlementFOMOReward(uint256 _stepIndex, address[] memory _funders, uint256 totalFOMOReward)
        public
        platform()
    {
        address[] memory FOMOWinnerList = FOMORewardInstance.dealFOMOWinner(_stepIndex, _funders, totalFOMOReward);

        for(uint i = 0; i < FOMOWinnerList.length; i++){
            FOMOBalance[_stepIndex][FOMOWinnerList[i]] = FOMORewardInstance.FOMORewardAmount(_stepIndex, FOMOWinnerList[i]);
        }
    }

    /// @notice 分配幸运奖励奖金
    function settlementLuckyReward(uint256 _stepIndex, address[] memory _LuckyWinnerList, uint256 totalLuckyReward)
        public
        platform()
    {
        luckyRewardInstance.dealLuckyInfo(_stepIndex, _LuckyWinnerList, totalLuckyReward);
        for(uint i = 0; i < _LuckyWinnerList.length; i++){
            LuckyBalance[_stepIndex][_LuckyWinnerList[i]] = luckyRewardInstance.luckyRewardAmount(_stepIndex, _LuckyWinnerList[i]);
        }
    }

    // 分配信仰奖励
    function dmSettlementFaithReward(address[] memory _faithWinners, uint256 totalFaithReward)
        public
        platform()
        returns(bool)
    {
        bool faithRewardFinished = faithRewardInstance.dealFaithWinner(_faithWinners, totalFaithReward);

        for(uint i = 0; i < _faithWinners.length; i++){
            faithRewardBalance[_faithWinners[i]] += faithRewardInstance.faithRewardAmount(_faithWinners[i]);
        }
        return faithRewardFinished;
    }

    // 获取信仰奖励金额
    function getFaithRewardBalance(address _addr) public view returns(uint256) {
        return faithRewardBalance[_addr];
    }

    function setFaithRewardBalance(address _addr, uint256 _amount) public platform() returns(uint256) {
        return faithRewardBalance[_addr] = _amount;
    }

    /// @notice 返回可提取Token数量
    function withdrawTokenAmount(uint256 _stepIndex, address _addr) public view returns (uint256) {
        return tokenBalance[_stepIndex][_addr];
    }

    /// @notice 返回可提取的ETH数量
    function withdrawETHAmount(uint256 _stepIndex, address _addr) public view returns (uint256) {
        return ETHBalance[_stepIndex][_addr]
            .add(FissionBalance[_stepIndex][_addr])
            .add(FOMOBalance[_stepIndex][_addr])
            .add(LuckyBalance[_stepIndex][_addr]);
    }

    function emptyTokenBalance(uint256 _stepIndex, address _addr) public platform() {
        tokenBalance[_stepIndex][_addr] = 0;
    }

    function emptyETHBalance(uint256 _stepIndex, address _addr) public platform() {
        ETHBalance[_stepIndex][_addr] = 0;
        FissionBalance[_stepIndex][_addr] = 0;
        FOMOBalance[_stepIndex][_addr] = 0;
        LuckyBalance[_stepIndex][_addr] = 0;
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

    /// @notice 获取当前轮次项目方占比
    function getBuildingPercentOfParty() public view returns(uint256) {
        return buildingPercentOfParty;
    }

    /// @notice 改变共振资金池共建比例
    function updateBuildingPercent(uint256 _stepIndex) public platform() returns (bool) {
        require(fundsPool > 0, "共建资金池已经消耗完毕");
        if(_stepIndex == 0){
            buildingTokenFromParty[_stepIndex] = initBuildingTokenAmount.mul(50).div(100);
            buildingPercentOfParty = 50;
            buildingPercentOfCommunity = 50;
        }else{
            // 随着轮次推进，社区比例每轮次+1%，项目方比例每轮-1%
            if(buildingPercentOfParty < 66){
                buildingPercentOfParty += 1;
                buildingPercentOfCommunity -= 1;
            }
            // 计算当前轮次一共开放的Token数量
            // 每一轮是前一轮总数的99%，也就是（每一轮开放数量 = 前一轮的开放数量 - 前一轮开放数量 * 1%）
            initBuildingTokenAmount = initBuildingTokenAmount.sub(initBuildingTokenAmount.mul(1).div(100));
            // 计算当前轮次基金会可投入的数量
            setBuildingTokenFromParty(_stepIndex, initBuildingTokenAmount.mul(buildingPercentOfParty).div(100));
        }

        return true;
    }

    /// @notice 设置当前轮次基金会应该投入的Token数量
    function setBuildingTokenFromParty(uint256 _stepIndex, uint256 _buildingPercentOfParty) internal platform() {
        buildingTokenFromParty[_stepIndex] = _buildingPercentOfParty;
    }

    /// @notice 当前轮次基金会应该投入的Token数量
    function getBuildingTokenFromParty(uint256 _stepIndex) public view returns(uint256) {
        return buildingTokenFromParty[_stepIndex];
    }

}