// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
Unchecked Math
Solidity 0.8 中数字的上溢和下溢会引发错误。
可以通过使用 unchecked 来禁用此功能。
禁用溢出/下溢检查可以节省gas。
*/

contract UncheckedMath {
    function add(uint x, uint y) external  pure returns (uint) {
        // 22291 gas
        // return x + y;
        // 22103 gas
        unchecked {
            return x + y;
        }

    }
    function sub(uint x, uint y) external pure returns (uint) {
        // 22329 gas
        // return x - y;

        // 22147 gas
        unchecked {
            return x - y;
        }
    }

    function sumOfCubes(uint x, uint y) external pure returns (uint) {
        // 将复杂的数学逻辑封装在未检查的内部
        unchecked {
            uint x3 = x * x * x;
            uint y3 = y * y * y;

            return x3 + y3;
        }
    }
}

