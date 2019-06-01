pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

// FOMO奖励 5%
// 每一轮最后一名参与者获得2.5%奖励，倒数第2名获得1%，倒数3、4、5名各获得0.5%

contract FOMOReward {

    using SafeMath for uint256;

    event FOMOWinnerInfo(address[] FOMOWinners, uint256[] FOMORewards);

    // 获奖者数组
    mapping(uint256 => address[]) public FOMOWinners;
    // 奖金数组
    mapping(uint256 => uint256[]) public FOMORewards;
    // step => 获奖地址 => 奖金
    mapping(uint256 => mapping(address => uint256)) public FOMORewardAmount;
    // 用户累计奖金
    mapping(address => uint256) public FOMOFunderTotalBalance;

    // 裂变奖励分配结束
    mapping(uint256 => bool) currentStepHasFinished;

    mapping(uint256 => uint256) totalFOMOReward;

    constructor() public {

    }

    /// @notice 获取FOMO获胜者列表和奖金列表
    function getFOMOWinnerInfo(uint256 _stepIndex)
        public
        view
        returns(uint256, address[] memory, uint256[] memory)
    {
        // emit FOMOWinnerInfo(FOMOWinners[_stepIndex], FOMORewards[_stepIndex]);
        return(totalFOMOReward[_stepIndex], FOMOWinners[_stepIndex], FOMORewards[_stepIndex]);
    }

    // 处理FOMO奖励
    function dealFOMOWinner(
        uint256 _stepIndex,
        address[] memory _funders,
        uint256 _totalFOMOReward
    )
        public
        returns(address[] memory)
    {
        require(!currentStepHasFinished[_stepIndex], "当前轮次的FOMO奖励已经计算完成");
        return _dealWinnerInfo(_stepIndex, _funders, _totalFOMOReward);
    }

    // 处理获奖者信息，分配获奖金额
    // 接受当前轮次的参与者、FOMO总奖励资金
    function _dealWinnerInfo(
        uint256 _stepIndex,
        address[] memory _funders,
        uint256 _totalFOMOReward
    )
        internal
        returns(address[] memory)
    {
        uint256 fundersLen;

        if(_funders.length >= 6){
            fundersLen = 6;
        }else{
            fundersLen = _funders.length;
        }

        FOMORewards[_stepIndex] = new uint256[](fundersLen);
        FOMOWinners[_stepIndex] = new address[](fundersLen);

        for(uint i = 0; i < fundersLen; i++){
            if(i == 0) {
                FOMORewards[_stepIndex][i] = _totalFOMOReward.mul(50).div(100);
            }else if(i == 1) {
                FOMORewards[_stepIndex][i] = _totalFOMOReward.mul(20).div(100);
            }else{
                FOMORewards[_stepIndex][i] = _totalFOMOReward.mul(10).div(100);
            }

            FOMOWinners[_stepIndex][i] = _funders[fundersLen-1-i];

            FOMORewardAmount[_stepIndex][FOMOWinners[_stepIndex][i]] = FOMORewards[_stepIndex][i];

            // 保存FOMO中用户总奖励
            FOMOFunderTotalBalance[FOMOWinners[_stepIndex][i]] += FOMORewardAmount[_stepIndex][FOMOWinners[_stepIndex][i]];
        }

        currentStepHasFinished[_stepIndex] = true;
        totalFOMOReward[_stepIndex] = _totalFOMOReward;
        return FOMOWinners[_stepIndex];
    }

    // 确认奖励金是正确的
    function getTotalRewardAmount(uint256 _stepIndex) public view returns(uint256) {
        uint totalAmount = 0;
        for(uint i = 0; i < FOMORewards[_stepIndex].length ; i++){
            totalAmount += FOMORewards[_stepIndex][i];
        }

        return totalAmount;
    }
}