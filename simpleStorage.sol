// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
若要写入或更新状态变量，您需要发送一个事务。另一方面，您可以免费读取状态变量，而无需支付任何交易费用。
*/
contract SimpleStorage {
    // 用于存储数字的状态变量
    uint public num;
    // 您需要发送一个事务来写入状态变量。
    function set(uint _num) public {
        num = _num;
    }
    // 您可以在不发送事务的情况下读取状态变量。
    function get() public view returns (uint) {
        return num;
    }

}