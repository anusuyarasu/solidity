pragma solidity ^0.4.0;
import "./ERC20.sol";
contract Token is ERC20{
    mapping(address=>uint256)public balances;
    mapping(address => mapping(address => uint256)) alowed;
    address owner;
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;
    function Token()public{
        name="ANU";
        symbol="@ANU";
        decimals=18;
        totalSupply=5000;
        owner=msg.sender;
        balances[owner]=totalSupply;
    }
    modifier check(){
        require(totalSupply>=balances[owner]);
        _;
    }
    modifier onlyowner(){
        require(owner==msg.sender);
         _;
    }
     function balanceOf()public constant returns(uint256){
         return balances[owner];
     }
    function transfer(address to,uint256 amount)public onlyowner()  check() returns(bool){
         require(totalSupply>amount);
         balances[owner]-=amount;
         return true;
    }
    function mint(uint256 amount)public onlyowner()  returns(uint256){
        // require(totalSupply>amount && totalSupply>=balances[owner] );
         balances[owner]+=amount;
         require(totalSupply>amount && totalSupply>=balances[owner] );
         return amount;
    }
     function transferFrom(address _from,address _to,uint256 _value) returns(bool success) {
         require (balances[_from] >= _value && _value > 0 && alowed[_from][_to] >= _value);
             
             balances[_from] -= _value;
             balances[_to] += _value;
             alowed[_from][_to] -= _value;
             return true;
     }
    function approve(address _spender,uint256 _value) returns(bool success){
         alowed[msg.sender][_spender] = _value;
         return true;
     }
     
     
     function allowance(address _owner,address _spender) constant returns(uint256 remaining){
         return alowed[_owner][_spender];
     }
     
    
}
