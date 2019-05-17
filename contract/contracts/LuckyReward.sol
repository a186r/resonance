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

    // 创建数组用于接收中奖地址
    address[] LuckyAddress;

    constructor() public {

    }

    // 用户应该来自于募资期转入ETH的用户
    // TODO:如果funder数组很大的话，会消耗很多gas，导致执行失败，我之后测试一下
    function findLuckyMan(
        address[] memory _funders,
        uint256 _blockNum
    )
        public
        returns(address[] memory)
    {
        require(block.number >= (_blockNum+1), "请等待下一个区块再执行");

        // 获取下一个区块的区块Hash
        bytes32 nextBlockhash = blockhash(_blockNum+1);

        // 比较
        for(uint i = 0; i < _funders.length; i++){
            if(StringUtils.compareString(getLastFromAddress(_funders[i]), getLastFromBlockHash(nextBlockhash))) {
                LuckyAddress.push(_funders[i]);
            }
        }

        return LuckyAddress;
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