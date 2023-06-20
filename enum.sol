// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

import "./array.sol";
/*
Solidity支持可枚举，它们对于建模选择和跟踪状态很有用。
Enums 可以在合约外声明
*/
contract Enum {
    // Enum 表示运输状态
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    //默认值是 类型定义中列出的第一个元素，在本例中为“Pending”
    Status public status;

    // Returns uint
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4

    function get() public view returns (Status) {
        return status;
    }

    //通过将uint传递到输入中来更新状态
    function set(Status _status) public {
        status = _status;
    }

    //更新到特定的枚举
    function cancel() public {
        status = Status.Canceled;
    }

    //delete将枚举重置为其第一个值0
    function reset() public {
        delete status;
    }


}
// 导入枚举
contract Enum1 {
    Status public status;
}
    