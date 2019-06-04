pragma solidity >=0.4.21 <0.6.0;
import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Authority is Ownable{

    mapping(address => bool) hasAccess;

    event SetAuthority(bool hasAccess);

    constructor () public {
    }

    modifier onlyAuthority() {
        // require(hasAccess[msg.sender], "调用者必须是ResonanceDataManage合约");
        _;
    }

    function setAuthority(address _authority) public onlyOwner() {
        hasAccess[_authority] = true;
        emit SetAuthority(hasAccess[_authority]);
    }
}