// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
Events允许登录以太坊区块链。Events用例包括：
监听事件和更新用户界面
一种廉价的存储形式
*/

contract Event {
    // 事件声明 
    //  最多可以索引 3 个参数。
    // 索引参数可帮助您通过索引参数过滤日志
    event Log(address indexed sender, string);
    event AnotherLog();
    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}