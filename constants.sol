// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
常量是不能修改的变量。它们的值是硬编码的，使用常量可以节省gas成本。
*/
contract Constants {
    // 大写常量变量的编码约定
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint public constant MY_UINT =123;
}