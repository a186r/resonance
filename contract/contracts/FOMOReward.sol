pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

// FOMO奖励 5%
// 每一轮最后一名参与者获得2.5%奖励，倒数第2名获得1%，倒数3、4、5名各获得0.5%

contract FOMOReward {
    using SafeMath for uint256;

    struct Winner{
        address winnerAddr;
        uint256 reward;
    }

    Winner[] public winners;

    mapping(address => uint) public totalRewardAmount;

    constructor() public {

    }

    // FOMOReward 用于FOMO的奖励,wei
    function findFOMOWinner(
        address[] memory _funders,
        uint256 _totalFOMOReward
    )
        public
    {
        uint fundersLen = _funders.length;

        // 第一名获得2.5%的奖励
        winners.push(Winner(_funders[fundersLen-1], _totalFOMOReward.mul(25).div(1000)));

        // 第二名获得1%的奖励
        winners.push(Winner(_funders[fundersLen-2], _totalFOMOReward.mul(10).div(1000)));

        // 第3、4、5名各获得0.5%的奖励
        winners.push(Winner(_funders[fundersLen-3], _totalFOMOReward.mul(5).div(1000)));
        winners.push(Winner(_funders[fundersLen-4], _totalFOMOReward.mul(5).div(1000)));
        winners.push(Winner(_funders[fundersLen-5], _totalFOMOReward.mul(5).div(1000)));
    }

    // 确认奖励金额是正确的
    function getTotalRewardAmount() public view returns (uint256) {
        // uint[] memory winners = new uint[](totalRewardAmount[]);
        uint totalCount = 0;

        for(uint i = 0; i < winners.length; i++) {
            totalCount += winners[i].reward;
        }

        return totalCount;
    }

}