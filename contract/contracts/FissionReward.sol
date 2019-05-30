pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./UintUtils.sol";

// 1.裂变奖励
// 裂变奖励可以在当前轮次的募资期计算结果，并预分配奖励额
// 获取裂变排序列表
// 这一步必须在募资期完成

// TODO:如果要共享结构体，可以将结构体放在一个struct中，暂时先不拆
contract FissionReward {

    using SafeMath for uint256;

    constructor() public {

    }

    event FissionInfo(uint256 indexed _stepIndex, address[] fissionWinners, uint256[] fissionRewards);

    // 当前轮次的推广者
    mapping(uint256 => address[]) public affmanArray;
    // 推广者赚取的Token
    mapping(uint256 => mapping(address => uint256)) public affmanEarnedToken;

    // 获奖者数组
    mapping(uint256 => address[]) public fissionWinners;
    // 奖金数组
    mapping(uint256 => uint256[]) public fissionRewards;
    // step => 获奖地址 => 奖金
    mapping(uint256 => mapping(address => uint256)) public fissionRewardAmount;
    // 用户累计奖金
    mapping(address => uint256) public fissionFunderTotalBalance;

    // 裂变奖励分配结束
    mapping(uint256 => bool) currentStepHasFinished;

    // 轮次=>奖励金
    mapping(uint256 => uint256) totalFissionReward;
 
    /// @notice 获取裂变奖励信息
    function getFissionInfo(uint256 _stepIndex)
        public
        view
        returns(uint256, address[] memory, uint256[] memory)
    {
        // emit FissionInfo(_stepIndex, fissionWinners[_stepIndex], fissionRewards[_stepIndex]);
        return(totalFissionReward[_stepIndex], fissionWinners[_stepIndex], fissionRewards[_stepIndex]);
    }

    /// @notice 处理裂变奖励信息
    function dealFissionInfo(
        uint256 _stepIndex,
        address[] memory _fissionWinner,
        uint256 _totalFissionReward
    ) public {
        require(!currentStepHasFinished[_stepIndex], "本轮次裂变奖励已经分配结束");
        _dealFissionInfo(_stepIndex, _fissionWinner, _totalFissionReward);
    }

    function addAffman(
        uint256 _stepIndex,
        address _promoter,
        address _initialFissionPerson
    ) public {
        if(_promoter != _initialFissionPerson){
            if(affmanArray[_stepIndex].length == 0){
                affmanArray[_stepIndex].push(_promoter);
            }else{
                for(uint i = 0; i < affmanArray[_stepIndex].length; i++){
                    if(_promoter != affmanArray[_stepIndex][i]){
                        affmanArray[_stepIndex].push(_promoter);
                        affmanEarnedToken[_stepIndex][_promoter] = UintUtils.toWei(5);
                    }else{
                        affmanEarnedToken[_stepIndex][_promoter] += UintUtils.toWei(5);
                    }
                }
            }
        }else{
            return;
        }
    }

    /// @notice 处理裂变奖励信息
    function _dealFissionInfo(
        uint256 _stepIndex,
        address[] memory _fissionWinner,
        uint256 _totalFissionReward
    )
        internal
    {

        uint256 winners;

        if(_fissionWinner.length >= 50){
            winners = 50;
        }else{
            winners = _fissionWinner.length;
        }

        fissionWinners[_stepIndex] = new address[](winners);

        fissionRewards[_stepIndex] = new uint256[](winners);

        fissionWinners[_stepIndex] = _fissionWinner;

        for(uint8 i = 0; i < winners; i++) {
            if (i == 0) { //第1名奖励10%
                fissionRewards[_stepIndex][i] = (_totalFissionReward.mul(10).div(100));
            } else if (i >= 1 && i <= 2) { // 第2、3名奖励
                fissionRewards[_stepIndex][i] = (_totalFissionReward.mul(75).div(1000));
            } else if (i >= 3 && i <= 5) {
                fissionRewards[_stepIndex][i] = (_totalFissionReward.mul(5).div(100));
            } else if (i >= 6 && i <= 9) {
                fissionRewards[_stepIndex][i] = (_totalFissionReward.mul(25).div(1000));
            } else {
                fissionRewards[_stepIndex][i] = (_totalFissionReward.mul(50).div(100).div(40));
            }

            // 设置余额
            fissionRewardAmount[_stepIndex][fissionWinners[_stepIndex][i]] = fissionRewards[_stepIndex][i];

            // 保存总奖励金额
            fissionFunderTotalBalance[fissionWinners[_stepIndex][i]] += fissionRewardAmount[_stepIndex][fissionWinners[_stepIndex][i]];
        }

        totalFissionReward[_stepIndex] = _totalFissionReward;

        currentStepHasFinished[_stepIndex] = true;
    }

}