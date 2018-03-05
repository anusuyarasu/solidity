pragma solidity ^0.4.0;
contract Token{
    function balanceOf(address _owner) constant returns (uint256 balance) {}
    function transfer(address _to, uint256 _value) returns (bool success) {}
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}
    function approve(address _spender, uint256 _value) returns (bool success) {}
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
}

contract StandardToken is Token{
    
     mapping (address => uint256) balances;
     mapping(address => mapping(address => uint256)) alowed;
     uint256 public totalSupply;
     address public owner;
    function StandardToken()public{
        owner=msg.sender;
    }
    modifier check(){
        require(msg.sender==owner);
        _;
    }
     function deposit(uint256 amount) public check() returns(uint256){
        balances[owner]+=amount;
        return balances[owner];
    }
    function withdraw(uint256 amount) public check() returns(uint256){
        require(balances[owner]>=amount && amount>0);
        balances[owner]-=amount;
        return balances[owner];
    }
    function transfer(address _to,uint256 _value) returns(bool success) {
         if (balances[msg.sender] >= _value && _value > 0 ){
             
             balances[msg.sender] -= _value;
             balances[_to] += _value;
             Transfer(msg.sender,_to,_value);
             return true;
         }
         else{
             return false;
         }
     }
     
     function transferFrom(address _from,address _to,uint256 _value) returns(bool success) {
         if (balances[_from] >= _value && _value > 0 && alowed[_from][_to] >= _value){
             
             balances[_from] -= _value;
             balances[_to] += _value;
             alowed[_from][_to] -= _value;
             Transfer(_from,_to,_value);
             return true;
         }
         else{
             return false;
         }
     }
     
     function balanceOf(address _owner) constant returns(uint256 balance){
         return balances[_owner];
     }
     
     function approve(address _spender,uint256 _value) returns(bool success){
         alowed[msg.sender][_spender] = _value;
         Approval(msg.sender,_spender,_value);
         return true;
     }
     
     
     function allowance(address _owner,address _spender) constant returns(uint256 remaining){
         return alowed[_owner][_spender];
     }
     function transferOwnership(address newOwner) public check() {
           require(newOwner != address(0));
           OwnershipTransferred(owner, newOwner);
            owner = newOwner;
     }
     
}

contract TestCoin is StandardToken{
    
    string public name;
    uint8 public decimals;
    string public symbol;
    function TestCoin(){
        balances[msg.sender] = 5000;
        totalSupply = 5000;
        name = "Anu Token";
        symbol = "ANU";
        decimals = 18;
        
    }
}
