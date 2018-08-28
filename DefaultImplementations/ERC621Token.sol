pragma solidity ^0.4.24;

import "../Interfaces/ERC621Interface.sol";
import "./ERC233Token.sol";

// import "github.com/nic0lae/TokenLib/Interfaces/ERC621Interface.sol";
// import "github.com/nic0lae/TokenLib/DefaultImplementations/ERC233Token.sol";
 
contract ERC621Token is ERC233Token, ERC621Interface {

    // ~~~~ ~~~~ ~~~~ ERC621Interface REQUIRED Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    function increaseSupply(uint value, address to) public returns (bool) {
        setTotalSupply(safeAdd(totalSupply(), value));

        updateBalanceForAddress(to, safeAdd(getBalanceForAddress(to), value));

        emit Transfer(0, to, value);
        return true;
    }

    function decreaseSupply(uint value, address from) public returns (bool) {
        updateBalanceForAddress(from, safeSub(getBalanceForAddress(from), value));

        setTotalSupply(safeSub(totalSupply(), value));

        emit Transfer(from, 0, value);
        return true;
    }


    // ~~~~ ~~~~ ~~~~ Helpers ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    function safeAdd(uint a, uint b) internal returns (uint) {
        if (a + b < a) {
            revert("b can't be negative");
        }
        return a + b;
    }

    function safeSub(uint a, uint b) internal returns (uint) {
        if (b > a) {
            revert("b can't be greater");
        }
        return a - b;
    }
}
