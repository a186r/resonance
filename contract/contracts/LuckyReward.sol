pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./StringUtils.sol";

// 2.10%用于幸运奖励
// 每一轮结束后下一个ETH区块高度Hash最后一位作为幸运值
// 用户钱包地址的最后一位与幸运值相同，则瓜分10%奖励。
// 募资期结束的时间就是当前轮次结束的时间，到达结束时间之后不再允许转入ETH，并在此时获取到最新的区块高度
// 然后查询下一区块高度的Hash（此时需要保证已经出块）
// 匹配幸运者
// 这个合约给到外面的只有一个获奖者列表

contract LuckyReward{

    using SafeMath for uint256;

    event LuckyInfo(address[] luckyWinners, uint256 luckyRewards);

    // 创建数组用于接收中奖地址
    mapping(uint256 => address[]) luckyWinners;

    // 人均奖金
    mapping(uint256 => uint256) luckyRewards;

    // step => 获奖地址 => 奖金
    mapping(uint256 => mapping(address => uint256)) public luckyRewardAmount;

    mapping(address => uint256) public luckyFunderTotalBalance;

    // 幸运奖励分配结束
    mapping(uint256 => bool) currentStepHasFinished;

    mapping(uint256 => uint256) totalLyckyReward;

    constructor() public {

    }

    // 获取某轮次幸运者列表和平均获奖金额
    function getLuckyInfo(uint256 _stepIndex)
        public
        view
        returns(uint256, address[] memory, uint256)
    {
        // emit LuckyInfo(luckyWinners[_stepIndex], luckyRewards[_stepIndex]);
        return(totalLyckyReward[_stepIndex], luckyWinners[_stepIndex], luckyRewards[_stepIndex]);
    }

    /// @notice 处理信用奖励信息
    function dealLuckyInfo(
        uint256 _stepIndex,
        address[] memory _luckyWinners,
        uint256 _totalLyckyReward
    ) public {
        require(!currentStepHasFinished[_stepIndex], "当前轮次的幸运奖励已经计算完成");
        _dealLuckyInfo(_stepIndex, _luckyWinners, _totalLyckyReward);
    }

    // 处理幸运者数据
    function _dealLuckyInfo(
        uint256 _stepIndex,
        address[] memory _luckyWinners,
        uint256 _totalLyckyReward
    )
        internal
    {
        luckyWinners[_stepIndex] = _luckyWinners;

        // 计算人均奖金
        luckyRewards[_stepIndex] = _totalLyckyReward.div(luckyWinners[_stepIndex].length);

        for(uint i = 0; i < luckyWinners[_stepIndex].length; i++){
            luckyRewardAmount[_stepIndex][luckyWinners[_stepIndex][i]] = luckyRewards[_stepIndex];

            // 累加奖金余额
            luckyFunderTotalBalance[luckyWinners[_stepIndex][i]] += luckyRewardAmount[_stepIndex][luckyWinners[_stepIndex][i]];
        }

        currentStepHasFinished[_stepIndex] = true;
        totalLyckyReward[_stepIndex] = _totalLyckyReward;
    }

    // 获取address的最后一位
    function getLastFromAddress(address _addr) public pure returns(string memory) {
        string memory addressStr = StringUtils.addr2string(_addr);
        return StringUtils.substring(addressStr,41,42);
    }

    // 获取区块Hash的最后一位
    function getLastFromBlockHash(bytes32 _blockHash) public pure returns(string memory){
        return StringUtils.substring(StringUtils.bytes32Tostring(_blockHash),_blockHash.length-1,_blockHash.length);
    }
}