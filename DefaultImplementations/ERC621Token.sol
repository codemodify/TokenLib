pragma solidity ^0.4.24;

// import "../Interfaces/ERC621Interface.sol";
// import "./ERC233Token.sol";

import "https://github.com/nic0lae/TokenLib/Interfaces/ERC621Interface.sol";
import "https://github.com/nic0lae/TokenLib/DefaultImplementations/ERC233Token.sol";

contract ERC621Token is ERC233Token, ERC621Interface {

    // ~~~~ ~~~~ ~~~~ ERC621Interface REQUIRED Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    function increaseSupply(uint value, address to) public returns (bool) {
        totalSupply = safeAdd(totalSupply, value);
        balances[to] = safeAdd(balances[to], value);
        Transfer(0, to, value);
        return true;
    }

    function decreaseSupply(uint value, address from) public returns (bool) {
        balances[from] = safeSub(balances[from], value);
        totalSupply = safeSub(totalSupply, value);  
        Transfer(from, 0, value);
        return true;
    }


    // ~~~~ ~~~~ ~~~~ Helpers ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    function safeAdd(uint a, uint b) internal returns (uint) {
        if (a + b < a) {
            throw;
        }
        return a + b;
    }

    function safeSub(uint a, uint b) internal returns (uint) {
        if (b > a) {
            throw;
        }
        return a - b;
    }
}
