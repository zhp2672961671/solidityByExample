// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
不可变的变量就像常量。不可变变量的值可以在构造函数内部设置，但之后不能修改。
*/
contract Immutable {
    //大写常量变量的编码约定
    address public immutable MY_ADRESS;
    uint public immutable MY_UINT;
    constructor(uint _myUint) {
        MY_ADRESS =msg.sender;
        MY_UINT = _myUint;
    }
}