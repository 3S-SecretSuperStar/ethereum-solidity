contract SweatySocks{
    
    uint public constant _totalsupply = 10000000;
    
    
    string public constant symbol = "SSocks!";
    string public constant name = "SweatySocks";
    uint8 public constant decimals = 4;
    
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    function SweatySocks(){
        balances[msg.sender] = _totalsupply;
    }
    
    //Get the total token supply
    function totalsupply() constant returns (uint256 totalsupply){
        return _totalsupply;
    }
    
    //Get the account balance of another account with address _owner
    function balanceof(address _owner) constant returns (uint256 balance){
        return balances[_owner];
    }
    
    //Send _value amount of tokens to address _to
    function transfer(address _to, uint256 _value) returns (bool success) {
        require(
                balances[msg.sender] >= _value
                && _value > 0
            );
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
    }
    
    /*Send _value amount of tokens from address _from to address _to

The transferFrom method is used for a withdraw workflow, allowing 
contracts to send tokens on your behalf, */
    
    
    function transerFrom(address _from, address _to, uint256 _value) returns (bool success){
        require(
            allowed[_from][msg.sender] >= _value
            
            &&balances[_from] >= _value
            &&_value > 0
        );
        balances[_from] -=_value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }
    
    //Allow _spender to withdraw from your account, multiple times, up to the _value amount. 
    //If this function is called again it overwrites the current allowance with _value
    
    function approve(address _spender, uint256 _value) returns (bool sucess){
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    //Returns the amount which _spender is still allowed to withdraw from _owner
    
    function allowance(address _owner, address _spender) constant returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
    //Triggered when tokens are transferred.
    event Transfer(address indexed _from, address indexed _to, uint _value);
    
    //Triggered whenever approve(address _spender, uint256 _value) is called
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
