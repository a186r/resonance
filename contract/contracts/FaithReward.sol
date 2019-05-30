pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

// 信仰奖励
contract FaithReward{
    using SafeMath for uint256;

    event FaithWinnerInfo(address[] _faithWinners, uint256[] _faithRewardAmount);

    // 信仰奖励获奖者
    address[] public faithWinners;

    // 信仰奖励金额
    mapping(address => uint256) public faithRewardAmount;

    uint256[] faithAmounts;

    // 信仰奖励分配结束
    bool public faithRewardFinished;

    uint256 totalFaithReward;

    constructor() public {

    }

    /// @notice 获取某轮次信仰奖励信息
    /// @return 轮次、获胜者列表、获胜者奖金列表
    function getFaithWinnerInfo()
        public
        view
        returns(uint256, address[] memory, uint256[] memory)
    {
        // emit FaithWinnerInfo(faithWinners, faithAmounts);
        return(totalFaithReward, faithWinners, faithAmounts);
    }

    // 链下排序,链上计算奖励分配
    // _faithWinners 信仰者名单
    function dealFaithWinner(
        address[] memory _faithWinners,
        uint256 _totalFaithReward
    )
        public
        returns(bool)
    {
        require(!faithRewardFinished, "当前轮次的信仰奖励已经计算完成");

        for(uint i = 0 ; i < _faithWinners.length; i++){
            if(i == 0){ // 第1名获得3%的奖励
                faithRewardAmount[_faithWinners[i]] = _totalFaithReward.mul(20).div(100);
            }else if(i >= 1 && i < 3){ // 第2、3名获得15%的奖励
                faithRewardAmount[_faithWinners[i]] = _totalFaithReward.mul(15).div(100);
            }else if(i >= 3 && i < 6){ // 第4、5、6名各获得1%的奖励
                faithRewardAmount[_faithWinners[i]] = _totalFaithReward.mul(10).div(100);
            }else{ // 第7、8、9、10各获得0.5%奖励
                faithRewardAmount[_faithWinners[i]] = _totalFaithReward.mul(5).div(100);
            }
            faithAmounts.push(faithRewardAmount[_faithWinners[i]]);
        }

        // 信仰奖励已经分配完成
        faithRewardFinished = true;
        totalFaithReward = _totalFaithReward;
        return faithRewardFinished;
    }

}