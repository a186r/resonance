pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

// 信仰奖励
contract FaithReward{
    using SafeMath for uint256;

    event FaithWinnerInfo(uint256 indexed _stepIndex, address[] _faithWinners, uint256[] _faithRewardAmount);

    // 信仰奖励获奖金额 step => 奖金
    mapping(uint256 => uint256[]) public faithRewards;

    // 信仰奖励获奖者
    mapping(uint256 => address[]) public faithWinners;

    mapping(uint256 => mapping(address => uint256)) public faithRewardAmount;

    // 用户累计奖金
    mapping(address => uint256) public faithFunderTotalBalance;

    // 信仰奖励分配结束
    mapping(uint256 => bool) public currentStepHasFinished;

    constructor() public {

    }

    /// @notice 获取某轮次信仰奖励信息
    /// @return 轮次、获胜者列表、获胜者奖金列表
    function getFaithWinnerInfo(uint256 _stepIndex) public {
        emit FaithWinnerInfo(_stepIndex, faithWinners[_stepIndex], faithRewards[_stepIndex]);
    }

    // 链下排序,链上计算奖励分配
    // _faithWinners 信仰者名单
    function dealFaithWinner(
        uint256 _stepIndex,
        address[10] memory _faithWinners,
        uint256 _totalFaithReward
    )
        public
    {
        require(!currentStepHasFinished[_stepIndex], "当前轮次的信仰奖励已经计算完成");

        for(uint i = 0 ; i < _faithWinners.length; i++){
            if(i == 0){ // 第一名获得3%的奖励
                faithRewards[_stepIndex].push(_totalFaithReward.mul(30).div(1000));
            }else if(i >= 1 && i < 3){ // 第二名获得2%的奖励
                faithRewards[_stepIndex].push(_totalFaithReward.mul(20).div(1000));
            }else if(i >= 3 && i < 6){ // 第3、4、5名各获得1%的奖励
                faithRewards[_stepIndex].push(_totalFaithReward.mul(10).div(1000));
            }else{ // 第7、8、9、10各获得0.5%奖励
                faithRewards[_stepIndex].push(_totalFaithReward.mul(5).div(1000));
            }

            faithRewardAmount[_stepIndex][_faithWinners[i]] = faithRewards[_stepIndex][i];
            // 保存用户信仰奖金总余额
            faithFunderTotalBalance[_faithWinners[i]] += faithRewardAmount[_stepIndex][_faithWinners[i]];

        }

        // 当前奖励已经分配完成
        currentStepHasFinished[_stepIndex] = true;
    }

    // 确认奖励金额是正确的
    function getTotalRewardAmount(uint256 _stepIndex) public view returns (uint256) {
        uint totalCount = 0;

        for(uint i = 0; i < faithRewards[_stepIndex].length; i++) {
            totalCount += faithRewards[_stepIndex][i];
        }

        return totalCount;
    }

}