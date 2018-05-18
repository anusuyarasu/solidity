pragma solidity ^0.4.0;


contract Inventory{
     
   uint256  public productCount=0;
   uint256  public ordercount=0;
   address public owner;
   
    struct product{
        uint pid;
        string pname;
        string pbrand;
        uint pquantity;
        uint pprice;
        uint time; 
    }
     struct productorder{
             uint id2;
             uint id1;
             address cid;
             string name;
             string brand;
             uint quantity;
             uint price;
             uint time;
             uint status;
            
    }
     struct in_order{
        uint ipid;
        uint iquantity;
        uint iprice;
    }    
       
    
                          
    
    mapping(uint=>product)public PROD;
    mapping(uint=>productorder)public ORDER;
    mapping(uint=>in_order)public UPDATE;
 
    function Inventory() payable public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require (owner == msg.sender);
        _;
    }
    
    function view1(uint id)public constant returns(uint){
         return (PROD[id].pprice);
     }
    
    function p_details(string name,string brand,uint quantity,uint price)public  payable onlyOwner   {
        
        PROD[productCount].pid = productCount;
        PROD[productCount].pname = name;
        PROD[productCount].pbrand = brand;
        PROD[productCount].pquantity = quantity;
        PROD[productCount].pprice = price;
        PROD[productCount].time = now;
        productCount++;
    }  
   
    function order(uint id,uint pquantity)public payable {
        
           require(id ==PROD[id].pid && pquantity <= PROD[id].pquantity);
           ORDER[ordercount].id2 = ordercount;
           ORDER[ordercount].cid = msg.sender;
           ORDER[ordercount].id1=id;
           ORDER[ordercount].name =PROD[id].pname ;
           ORDER[ordercount].brand =  PROD[id].pbrand;
           ORDER[ordercount].quantity=pquantity;
           ORDER[ordercount].price = pquantity *  PROD[id].pprice; 
           ORDER[ordercount].time = now;
           ORDER[ordercount].status = 1;
           PROD[id].pquantity-=pquantity;
           ORDER[ordercount].price = msg.value;
           ordercount++;
          
           
    }
   
    function update_product(uint id,uint _quantity,uint price)public onlyOwner  {
       
       UPDATE[id].ipid = id;
       UPDATE[id].iquantity = _quantity;
       UPDATE[id].iprice = price;
       PROD[id].pquantity+=_quantity;
       PROD[id].pprice= price;
       

     }
      
    function viewproduct(uint id)public constant returns(uint,string,string,uint,uint,uint){
           
        return(PROD[id].pid,PROD[id].pname,PROD[id].pbrand,  PROD[id].pquantity,PROD[id].pprice,PROD[id].time);
    }      
       
    function vieworder(uint id2)public constant returns(uint,address,uint,uint,uint,uint,uint){
        return (ORDER[id2].id2,ORDER[id2].cid, ORDER[id2].id1,  ORDER[id2].quantity,ORDER[id2].price, ORDER[id2].time, ORDER[id2].status);
    }   
       
    function outOfStock(uint id)public constant returns(uint,uint,uint){
        return (PROD[id].pid,PROD[id].pquantity,PROD[id].pprice);
    }   
       
    function ordercancel(uint oid,uint id)public{
        require(msg.sender== ORDER[oid].cid);
        uint t =(now -  ORDER[oid].time );
        require(t<= 3600 seconds);
        PROD[id].pquantity += ORDER[oid].quantity ;
        ORDER[oid].status = 0;
        msg.sender.transfer(ORDER[oid].price);
    }   
       
    function transferOwnership(address newowner) payable public onlyOwner {
        owner = newowner;
    }     

    function getbalance()public constant returns(uint256){
        return  address(this).balance;
    }    
        
    function withdraw(uint amount)payable public onlyOwner returns(bool) {
            uint x=amount *1 ether;
            require(x<address(this).balance);
            owner.transfer(x);
            return true;
    }    
        
        
    }
   
     
 
