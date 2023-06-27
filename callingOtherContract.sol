// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
合约可以通过两种方式致电其他合约。
最简单的方法就是直接调用它，例如 A.foo(x, y, z)。
调用其他合约的另一种方法是使用低级call。
不推荐这种方法。

*/

contract Callee {
    uint public x;
    uint public value;
    function setX(uint _x) public returns (uint) {
        x = _x;
        return x;
    }

    function setXandSendEther(uint _x) public payable returns (uint, uint) {
        x = _x;
        value = msg.value;

        return (x, value);
    }
}
contract Caller {
    function setX(Callee _callee, uint _x) public {
        uint x = _callee.setX(_x);
    }

    function setXFromAddress(address _addr, uint _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }
    function setXandSendEther(Callee _callee, uint _x) public payable {
         (uint x, uint value) = _callee.setXandSendEther{value: msg.value}(_x);
    }
}