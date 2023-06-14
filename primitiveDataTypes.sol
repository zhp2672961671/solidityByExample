// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

contract Primitives {
    // bool ：可能的取值为字面常量值 true 和 false 。
    bool public boo = true;
    /*
        uint代表无符号整数，这意味着可以使用不同大小的非负整数
        uint8   ranges from 0 to 2 ** 8 - 1
        uint16  ranges from 0 to 2 ** 16 - 1
        ...
        uint256 ranges from 0 to 2 ** 256 - 1
    */
    uint8 public u8 = 1;
    uint public  u256 = 456;
    uint public u = 123 ;
    /*
    int类型允许使用负数。与uint一样，从int8到int256有不同的范围
    int256 ranges from -2 ** 255 to 2 ** 255 - 1
    int128 ranges from -2 ** 127 to 2 ** 127 - 1
    */
    int8 public i8 = -1;
    int public i256 = 456;
    int public  i = -123;
    // int的最小值和最大值
    int public  minInt = type(int).min;
    int public  maxInt = type(int).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    bytes1 a = 0xb5; //  [10110101]
    bytes1 b = 0x56; //  [01010110]

    // Default values
    // 未分配的变量具有默认值
    bool public defaultBoo; // false
    uint public defaultUint; // 0
    int public defaultInt; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}