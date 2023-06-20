// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
有几种方法可以返回函数的输出。公共函数不能接受某些数据类型作为输入或输出
*/

contract Function {
    // 函数可以返回多个值。
    function returnMany() public pure returns (uint, bool, uint){
        return (1, true, 2);
    }
    // 返回值可以命名。
    function named() public pure returns (uint x, bool b, uint y) {
          return (1, true, 2);
    }
    // 返回值可以赋给它们的名字。
    // 在这种情况下，return 语句可以省略。
    function assigned() public pure returns (uint x, bool b, uint y){
        x =1;
        b =true;
        y =2;
    }
    //当调用另一个返回多个值的函数时，请使用析构函数赋值。pure 对于函数：不允许修改或访问状态。
    function destructuringAssignments() public pure returns (uint, bool, uint, uint, uint ) {
        (uint i, bool b, uint j) = returnMany();
        //值可以省略。
        (uint x, , uint y) = (4, 5, 6);
        return (i, b, j, x, y);
    }
    //不能将映射用于输入或输出
    // 可以使用数组进行输入
    function arrayInput(uint[] memory _arr) public {}
    // 可以使用数组进行输出
    uint[] public arr;
    function arrayOutput() public view returns (uint[] memory) {
        return arr;
    }
}
// 具有键值输入的调用函数
contract XYZ {
    function someFuncWithManyInputs(
        uint x,
        uint y,
        uint z,
        address a,
        bool b,
        string memory c
    ) public pure returns (uint){}
    function callFunc() external pure returns (uint) {
        return someFuncWithManyInputs(1, 2, 3, address(0), true, "c");
    }
    function callFuncWithKeyValue() external pure returns (uint) {
        return 
        someFuncWithManyInputs({a:address(0),b:true, c:"c", x:1, y:2, z:3});

    }
}