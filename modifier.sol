// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
函数修改器是可以在函数调用之前和/或之后运行的代码。
函数修改器可用于： 
限制访问 
验证输入 
防止重入黑客攻击
*/

contract FunctionModifier {
    address public owner;
    uint public x = 10;
    bool public locked;

    constructor(){
        // 将交易发送者设置为合约的所有者。
        owner = msg.sender;
    }
    //函数修改器，以检查调用方是否为合约的所有者。
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        //下划线是一个特殊字符，只在函数修改器中使用，它告诉Solidity执行其余代码。
        _;
    }
    // 修改器可以接受输入。此修改器检查传入的地址是否不是零地址。
    modifier  validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }
    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }
    //修改器可以在函数之前 或之后调用。此修改器可防止函数在执行时被调用
    modifier noReentrancy() {
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }
    function decrement(uint i) public noReentrancy {
        x -= i;
        if(i >1){
            decrement(i -1);
        }
    }


}
