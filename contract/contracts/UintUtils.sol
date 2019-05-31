pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

library UintUtils{

    using SafeMath for uint256;

    function toWei(uint256 _amount) public pure returns(uint256) {
        return _amount*10**18;
    }

    function toBytes(uint256 x) public pure returns (bytes memory b) {
        b = new bytes(32);
        assembly { mstore(add(b, 32), x) }
    }

}