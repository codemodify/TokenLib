pragma solidity ^0.4.24;

library SafeMath {

    // Multiplies two numbers, reverts on overflow.
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "((firstParam * secondParam) / firstParam) != secondParam");

        return c;
    }

    // Division of two integers, reverts on division by zero.
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "secondParam must be non-zero");
        uint256 c = a / b;

        return c;
    }

    // Subtracts two numbers, reverts on overflow.
    function sub(uint256 _a, uint256 _b) internal pure returns (uint256) {
        require(_b <= _a, "secondParam must be less than firstParam");
        uint256 c = _a - _b;

        return c;
    }

    // Adds two numbers, reverts on overflow.
    function add(uint256 _a, uint256 _b) internal pure returns (uint256) {
        uint256 c = _a + _b;
        require(c >= _a, "adding secondParam overflows the uint256 range");

        return c;
    }

    // Modulo two numbers, reverts when dividing by zero.
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "secondParam can't be zero");
        return a % b;
    }
}
