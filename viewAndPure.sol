// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
Getter函数可以声明为view或pure。View函数声明不会更改任何状态。pure函数声明不会更改或读取任何状态变量。
*/
contract viewAndPure {
    uint public x =1;
    // 承诺不修改状态。
    function addToX(uint y) public view returns (uint) {
        return x + y;
    }
    // 承诺不修改或读取状态。
    function add(uint i, uint j) public pure returns (uint) {
        return i + j;
    }
}