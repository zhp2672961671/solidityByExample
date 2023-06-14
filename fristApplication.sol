// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
// contract 合约类型
contract Counter {
    //uint  无符号的不同位数的整型变量 uint256的别名 public 外部和内部可见（为存储/状态变量创建getter函数）
    uint public count;
    //view 对于函数：不允许修改状态。 returns 返回值
    function get() public view returns (uint) {
        return count;
    }

    function inc() public {
        count +=1;
    }

    function dec() public {
        count -=1;
    }


}