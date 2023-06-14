// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
Solidity中有3种类型的变量
局部
在未存储在区块链上的函数内声明
状态
在存储在区块链上的函数外部声明
全局 (提供有关区块链的信息)
*/

contract Variables {
    // 状态变量存储在区块链上。
    string public text = "Hello";
    uint public num = 123;
    function daSomething() public view returns(uint, address, uint) {
        //局部变量不会保存到区块链中。
        uint i = 406;
        // 以下是一些全局变量
        uint timestamp = block.timestamp;//当前块时间戳
        address sender = msg.sender; // 调用者者地址
        return (timestamp, sender, i);

    }
}
