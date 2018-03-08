pragma solidity ^0.4.0;
contract ERC20{
    function balanceOf()public constant returns(uint256);
    function transfer(address to,uint256 amount)public  returns(bool);
    function mint(uint256 amount)public  returns(uint256);
    function transferFrom(address _from,address _to,uint256 _value) returns(bool success);
    function approve(address _spender,uint256 _value) returns(bool success);
    function allowance(address _owner,address _spender) constant returns(uint256 remaining);
}
