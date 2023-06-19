// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
solidity支持条件语句if、else if和else。
*/
contract IfElse {
    //pure 对于函数：不允许修改或访问状态。
    function foo(uint x) public pure returns (uint) {
        if(x< 10) {
            return 0;
        }else if(x< 20){
            return 1;
        }else{
            return 2;
        }
    }
    function ternary(uint _x) public pure returns (uint) {
        return _x< 10 ? 1 : 2;

    }
}