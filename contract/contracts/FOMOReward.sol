pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

// FOMO奖励 5%
// 每一轮最后一名参与者获得2.5%奖励，倒数第2名获得1%，倒数3、4、5名各获得0.5%

contract FOMOReward {
    
    using SafeMath for uint256;

    event FOMOWinnerInfo(address[] FOMOWinners, uint256[] FOMORewards);

    // 获奖者数组
    address[] FOMOWinners;
    // 奖金数组
    uint256[] FOMORewards;
    // 获奖者地址和奖金的映射
    // 公开mapping，可以通过地址查询奖励金额（step=>address=>rewardAmount）,这个在withdraw的时候会有用
    mapping(uint256 => mapping(address => uint256)) public FOMORewardAmount;
    
    bool hasFinished; // 裂变奖励分配结束


    constructor() public {

    }

    // 获取FOMO获胜者列表和奖金列表
    function getFOMOWinnerInfo(
        uint256 _stepIndex,
        address[] memory _funders,
        uint256 _totalFOMOReward
    )
        public
    {
        _dealWinnerInfo(_stepIndex, _funders, _totalFOMOReward);
        emit FOMOWinnerInfo(FOMOWinners, FOMORewards);
    }

    // 处理获奖者信息，分配获奖金额
    // 接受当前轮次的参与者、FOMO总奖励资金
    function _dealWinnerInfo(
        uint256 _stepIndex,
        address[] memory _funders,
        uint256 _totalFOMOReward
    )
        internal
    {
        uint256 fundersLen = _funders.length;

        for(uint i = 1; i < 6; i++){
            FOMOWinners.push(_funders[fundersLen-i]);
            if(i == 1) {
                FOMORewards.push(_totalFOMOReward.mul(25).div(1000));
            }else if(i == 2) {
                FOMORewards.push(_totalFOMOReward.mul(10).div(1000));
            }else{
                FOMORewards.push(_totalFOMOReward.mul(5).div(1000));
            }

            FOMORewardAmount[_stepIndex][FOMOWinners[i]] = FOMORewards[i];
        }
    }

    // 确认奖励金是正确的
    function getTotalRewardAmount() public view returns(uint256) {
        uint totalAmount = 0;
        for(uint i = 0; i < FOMORewards.length ; i++){
            totalAmount += FOMORewards[i];
        }
    }
}