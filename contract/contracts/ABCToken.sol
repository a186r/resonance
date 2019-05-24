pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Capped.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";

// 测试用的Token
contract ABCToken is ERC20, ERC20Detailed, ERC20Burnable, ERC20Capped {

    event CreateTokenSuccess(address owner, uint256 balance);

    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals
    )
        ERC20Burnable()
        ERC20Capped(150000000 * (10 ** uint256(decimals)))
        ERC20Detailed(name, symbol, decimals)
        ERC20()
        public
    {
        // 创建1.5亿个
        mint(msg.sender,150000000 * (10 ** uint256(decimals)));
        emit CreateTokenSuccess(msg.sender,balanceOf(msg.sender));
    }

    function mintToken() public {
        // 创建1.5亿个
        mint(msg.sender,150000000 * (10 ** uint256(18)));
        emit CreateTokenSuccess(msg.sender,balanceOf(msg.sender));
    }
}