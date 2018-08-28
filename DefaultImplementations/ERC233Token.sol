pragma solidity ^0.4.24;

import "../Helpers/SafeMath.sol";
import "../Interfaces/ERC20Interface.sol";
import "../Interfaces/ERC233Interface.sol";

contract ERC233Token is ERC20Interface, ERC233Interface {
    using SafeMath for uint256;

    // ~~~~ ~~~~ ~~~~ House Keeping ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    string private _tokenName;
    string private _tokenSymbol;
    uint8 private _tokenDecimals;

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowed;
    uint256 private _totalSupply;


    // ~~~~ ~~~~ ~~~~ Init ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    constructor(string tokenName, string tokenSymbol, uint8 tokenDecimals, uint totalSupply) public {
        _tokenName = tokenName;
        _tokenSymbol = tokenSymbol;
        _tokenDecimals = tokenDecimals;
        _totalSupply = totalSupply;
    }


    // ~~~~ ~~~~ ~~~~ ERC20Interface OPTIONAL Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    function name() public view returns (string) {
        return _tokenName;
    }

    function symbol() public view returns (string) {
        return _tokenSymbol;
    }

    function decimals() public view returns (uint8) {
        return _tokenDecimals;
    }


    // ~~~~ ~~~~ ~~~~ ERC20Interface REQUIRED Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(value <= _balances[msg.sender], "`sender` does not have enough funds");
        require(to != address(0), "`to` can't be 0");

        _balances[msg.sender] = _balances[msg.sender].sub(value);
        _balances[to] = _balances[to].add(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(value <= _balances[from], "`from` does not have enough funds");
        require(value <= _allowed[from][msg.sender], "`sender` by `from` is not authorized");
        require(to != address(0), "`to` can't be 0");

        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
        emit Transfer(from, to, value);

        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        _allowed[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);

        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }


    // ~~~~ ~~~~ ~~~~ ERC20Interface REQUIRED Events ~~~~ ~~~~ ~~~~ ~~~~ ~~~~

    // INFO: Events don't require an implementation body


    // ~~~~ ~~~~ ~~~~ ERC233Interface REQUIRED Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    function transfer(address to, uint256 value, bytes data ) public returns (bool) {
        if (isContract(to)) {
            _balances[msg.sender] -= value;
            _balances[to] += value;

            ERC233TokenReceiverInterface tokenReceiver = ERC233TokenReceiverInterface(to);
            tokenReceiver.tokenFallback(msg.sender, value, data);
            emit Transfer(msg.sender, to, value, data);

            return true;
        }
    }


    // ~~~~ ~~~~ ~~~~ Helpers ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    function isContract(address someAddress) private returns (bool) {
        uint length;
        assembly {
            length := extcodesize(someAddress)
        }
        return (length > 0);
    }






    /**
     * @dev Increase the amount of tokens that an owner _allowed to a spender.
     * approve should be called when _allowed[_spender] == 0. To increment
     * _allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     * From MonolithDAO Token.sol
     * @param _spender The address which will spend the funds.
     * @param _addedValue The amount of tokens to increase the allowance by.
     */
    function increaseApproval(
        address _spender,
        uint256 _addedValue
    )
        public
        returns (bool)
    {
        _allowed[msg.sender][_spender] = (
            _allowed[msg.sender][_spender].add(_addedValue));
        emit Approval(msg.sender, _spender, _allowed[msg.sender][_spender]);
        return true;
    }

    /**
     * @dev Decrease the amount of tokens that an owner _allowed to a spender.
     * approve should be called when _allowed[_spender] == 0. To decrement
     * _allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     * From MonolithDAO Token.sol
     * @param _spender The address which will spend the funds.
     * @param _subtractedValue The amount of tokens to decrease the allowance by.
     */
    function decreaseApproval(
        address _spender,
        uint256 _subtractedValue
    )
        public
        returns (bool)
    {
        uint256 oldValue = _allowed[msg.sender][_spender];
        if (_subtractedValue >= oldValue) {
            _allowed[msg.sender][_spender] = 0;
        } else {
            _allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
        }
        emit Approval(msg.sender, _spender, _allowed[msg.sender][_spender]);
        return true;
    }

    /**
     * @dev Internal function that mints an amount of the token and assigns it to
     * an account. This encapsulates the modification of _balances such that the
     * proper events are emitted.
     * @param _account The account that will receive the created tokens.
     * @param _amount The amount that will be created.
     */
    function _mint(address _account, uint256 _amount) internal {
        require(_account != 0);
        _totalSupply = _totalSupply.add(_amount);
        _balances[_account] = _balances[_account].add(_amount);
        emit Transfer(address(0), _account, _amount);
    }

    /**
     * @dev Internal function that burns an amount of the token of a given
     * account.
     * @param _account The account whose tokens will be burnt.
     * @param _amount The amount that will be burnt.
     */
    function _burn(address _account, uint256 _amount) internal {
        require(_account != 0);
        require(_amount <= _balances[_account]);

        _totalSupply = _totalSupply.sub(_amount);
        _balances[_account] = _balances[_account].sub(_amount);
        emit Transfer(_account, address(0), _amount);
    }

    /**
     * @dev Internal function that burns an amount of the token of a given
     * account, deducting from the sender's allowance for said account. Uses the
     * internal _burn function.
     * @param _account The account whose tokens will be burnt.
     * @param _amount The amount that will be burnt.
     */
    function _burnFrom(address _account, uint256 _amount) internal {
        require(_amount <= _allowed[_account][msg.sender]);

        // Should https://github.com/OpenZeppelin/zeppelin-solidity/issues/707 be accepted,
        // this function needs to emit an event with the updated approval.
        _allowed[_account][msg.sender] = _allowed[_account][msg.sender].sub(_amount);
        _burn(_account, _amount);
    }
}
