// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
变量被声明为storage、memory 或calldata，以明确指定数据的位置。
storage - 是一个状态变量（存储在区块链上）
memory - 变量在内存中，并且在调用函数时存在
calldata - 包含函数参数的特殊数据
*/
contract DataLocations {
    uint[] public arr;
    mapping(uint => address) map ;
    struct MyStrut {
        uint foo;
    }
    mapping (uint => MyStrut) myStructs;
    
    function f() public {
        _f(arr, map, myStructs[1]);
        // 从映射中获取一个结构体
        MyStrut storage myStrut =myStructs[1];
        //在memory上创建一个结构体
        MyStrut memory myMemStruct = MyStrut(0);
        
    }

    function _f(
        uint[] storage _arr,
        mapping(uint => address) storage _map,
        MyStrut storage _myStrust
    ) internal {

    }
    // 可以返回memory变量
    function g(uint[] memory _arr) public returns (uint[] memory) {

    }

    function h(uint[] calldata _arr) external {
        
    }
}
