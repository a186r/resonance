pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

// 信仰奖励
contract FaithReward{
    using SafeMath for uint256;

    event FaithWinnerInfo(uint256 indexed _stepIndex, address[10] _faithWinners, uint256[] _faithRewardAmount);
    // 幸运奖励获奖金额
    uint256[] faithRewardAmount;

    mapping(uint256 => mapping(address => uint256)) public rewardAmount;

    constructor() public {

    }

    // 链下排序,链上计算奖励分配
    // _faithWinners 信仰者名单
    function getFaithWinnerInfo(
        uint256 _stepIndex,
        address[10] memory _faithWinners,
        uint256 _totalFaithReward
    )
        public
    {
        for(uint i = 0 ; i < _faithWinners.length; i++){
            if(i == 0){ // 第一名获得3%的奖励
                faithRewardAmount.push(_totalFaithReward.mul(30).div(1000));
            }else if(i >= 1 && i < 3){ // 第二名获得2%的奖励
                faithRewardAmount.push(_totalFaithReward.mul(20).div(1000));
            }else if(i >= 3 && i < 6){ // 第3、4、5名各获得1%的奖励
                faithRewardAmount.push(_totalFaithReward.mul(10).div(1000));
            }else{ // 第7、8、9、10各获得0.5%奖励
                faithRewardAmount.push(_totalFaithReward.mul(5).div(1000));
            }

            rewardAmount[_stepIndex][_faithWinners[i]] = faithRewardAmount[i];
        }

        emit FaithWinnerInfo(_stepIndex, _faithWinners, faithRewardAmount);
    }

    // 确认奖励金额是正确的
    function getTotalRewardAmount() public view returns (uint256) {
        uint totalCount = 0;

        for(uint i = 0; i < faithRewardAmount.length; i++) {
            totalCount += faithRewardAmount[i];
        }

        return totalCount;
    }

}