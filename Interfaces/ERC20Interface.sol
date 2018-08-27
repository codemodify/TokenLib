pragma solidity ^0.4.24;

//
// Spec, Credits and Inspirations
//    - https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
//    - https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/token/ERC20/StandardToken.sol
//    - https://github.com/ConsenSys/Tokens/blob/master/contracts/eip20/EIP20.sol
//
// Implementation of adding the force to 0 before calling "approve" again:
//    - https://github.com/Giveth/minime/blob/master/contracts/MiniMeToken.sol
//
interface ERC20Interface {

    // ~~~~ ~~~~ ~~~~ OPTIONAL Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~

    // Returns the name of the token
    function name() external view returns (string);

    // Returns the symbol of the token
    function symbol() external view returns (string);

    // Returns the number of decimals the token uses
    function decimals() external view returns (uint8);


    // ~~~~ ~~~~ ~~~~ REQUIRED Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~

    // Returns the total token supply
    function totalSupply() external view returns (uint256);

    // Returns the account balance of `account`
    function balanceOf(address account) external view returns (uint256);

    // Transfers `value` amount of tokens `to` address. MUST fire `Transfer` event.
    // SHOULD throw if `from` account balance does not have enough tokens to spend.
    // Transfers of 0 values MUST be treated as normal transfers and fire the `Transfer` event.
    function transfer(address to, uint256 value) external returns (bool);

    // Transfers `value` amount of tokens `from` `to` addresses. MUST fire the `Transfer` event.
    //
    // This can be used for example to allow a contract to transfer tokens on your behalf and/or 
    // to charge fees in sub-currencies.
    //
    // The function SHOULD throw unless the `from` account has deliberately authorized the sender
    // of the message via some mechanism.
    //
    // Transfers of 0 values MUST be treated as normal transfers and fire the `Transfer` event.
    function transferFrom(address from, address to, uint256 value) external returns (bool);

    // Allows `spender` to withdraw from your account multiple times, up to the `value` amount
    // If this function is called again it overwrites the current allowance with `value`.
    // To prevent attack vectors clients SHOULD make sure to create user interfaces in such a 
    // way that they set the allowance first to 0 before setting it to another value for the same spender.
    // THOUGH The contract itself shouldn't enforce it, to allow backwards compatibility with older contracts.
    // Sample attack vectors:
    //     https://docs.google.com/document/d/1YLPtQxZu1UAvO9cZ1O2RPXBbT0mooh4DYKjA_jp-RLM
    //     https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
    function approve(address spender, uint256 value) external returns (bool);

    // Returns the amount which `spender` is still allowed to withdraw from `owner`
    function allowance(address owner, address spender) external view returns (uint256);


    // ~~~~ ~~~~ ~~~~ REQUIRED Events ~~~~ ~~~~ ~~~~ ~~~~ ~~~~

    // MUST trigger when tokens are transferred, including zero value transfers.
    // A token contract which creates new tokens SHOULD trigger a `Transfer` event
    // with the `from` address set to 0x0 when tokens are created.
    event Transfer(address indexed from, address indexed to, uint256 value);

    // MUST trigger on any successful call to `approve(address spender, uint256 value)`
    event Approval(address indexed owner, address indexed spender, uint256 value);
}