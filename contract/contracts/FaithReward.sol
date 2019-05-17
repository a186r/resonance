pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

// 信仰奖励
contract FaithReward{
    using SafeMath for uint256;

    struct FaithWinner{
        address winnerAddr;
        uint256 reward;
    }

    constructor() public {

    }

    FaithWinner[] public faithWinners;

    mapping(address => uint) public totalRewardAmount;

    // 链下排序，这一步只做奖励分配
    function findFaithWinner(
        address[] memory _funders,
        uint256 _totalFaithReward
    )
        public
    {
        // 第一名获得3%的奖励
        faithWinners.push(FaithWinner(_funders[0], _totalFaithReward.mul(30).div(1000)));

        // 第二名获得2%的奖励
        faithWinners.push(FaithWinner(_funders[1], _totalFaithReward.mul(20).div(1000)));
        faithWinners.push(FaithWinner(_funders[2], _totalFaithReward.mul(20).div(1000)));

        // 第3、4、5名各获得1%的奖励
        faithWinners.push(FaithWinner(_funders[3], _totalFaithReward.mul(10).div(1000)));
        faithWinners.push(FaithWinner(_funders[4], _totalFaithReward.mul(10).div(1000)));
        faithWinners.push(FaithWinner(_funders[5], _totalFaithReward.mul(10).div(1000)));
        // 7、8、9、10各获得0.5%奖励
        faithWinners.push(FaithWinner(_funders[6], _totalFaithReward.mul(5).div(1000)));
        faithWinners.push(FaithWinner(_funders[7], _totalFaithReward.mul(5).div(1000)));
        faithWinners.push(FaithWinner(_funders[8], _totalFaithReward.mul(5).div(1000)));
        faithWinners.push(FaithWinner(_funders[9], _totalFaithReward.mul(5).div(1000)));

    }

    // 确认奖励金额是正确的
    function getTotalRewardAmount() public view returns (uint256) {
        uint totalCount = 0;

        for(uint i = 0; i < faithWinners.length; i++) {
            totalCount += faithWinners[i].reward;
        }

        return totalCount;
    }

}