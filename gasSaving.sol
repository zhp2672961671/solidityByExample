// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
一些节约gas技术。
用 calldata 替换memory
将状态变量加载到内存
将 for 循环 i++ 替换为 ++i
缓存数组元素
Short circuit
*/

contract GasGolf {
    // start - 50908 gas
    // use calldata - 49163 gas
    // load state variables to memory - 48952 gas
    // short circuit - 48634 gas
    // loop increments - 48244 gas
    // cache array length - 48209 gas
    // load array elements to memory - 48047 gas
    // uncheck i overflow/underflow - 47309 gas

    uint public total;
    // start - not gas optimized
    // function sumIfEvenAndLessThan99(uint[] memory nums) external {
    //     for (uint i = 0; i < nums.length; i += 1) {
    //         bool isEven = nums[i] % 2 == 0;
    //         bool isLessThan99 = nums[i] < 99;
    //         if (isEven && isLessThan99) {
    //             total += nums[i];
    //         }
    //     }
    // }
    // gas优化
    // [1, 2, 3, 4, 5, 100]
    function sumIfEventAndLessThan99(uint[] calldata nums) external {
        uint _total = total;
        uint len = nums.length;
        for(uint i = 0; i < len; ){
            uint num =nums[i];
            if(num % 2 == 0 && num < 99) {
                _total += num;
            }
            unchecked  {
                ++i;
            }
        }
         total = _total;
    }


}

