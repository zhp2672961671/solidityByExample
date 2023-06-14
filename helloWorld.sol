// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
// contract 合约类型
contract HelloWorld {
    // 状态变量是永久地存储在合约存储中的值。  string  字符串   public 外部和内部可见（为存储/状态变量创建getter函数）
    string public greet = "Hello World;";
}