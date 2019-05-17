pragma solidity >=0.4.21 <0.6.0;

library StringUtils{

    // 地址转换为String
    function addr2string(address _addr) public pure returns(string memory) {
        bytes32 value = bytes32(uint256(_addr));
        return bytes32Tostring(value);
    }

    function bytes32Tostring(bytes32 _b) public pure returns(string memory) {
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(51);
        str[0] = '0';
        str[1] = 'x';
        for (uint i = 0; i < 20; i++) {
            str[2+i*2] = alphabet[uint8(_b[i + 12] >> 4)];
            str[3+i*2] = alphabet[uint8(_b[i + 12] & 0x0f)];
        }
        return string(str);
    }

    // 截取string
    function substring(string memory str, uint startIndex, uint endIndex) public pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex-startIndex);
        for(uint i = startIndex; i < endIndex; i++) {
            result[i-startIndex] = strBytes[i];
        }
        return string(result);
    }

    // 比较两个字符串是否相等
    function compareString(string memory a, string memory b) public pure returns(bool){
        if(bytes(a).length != bytes(b).length){
            return false;
        }else{
            return keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked(b));
        }
    }
}