// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
maps 创建语法 mapping(keyType => valueType)
 keyType可以是任何内置的值类型、字节、字符串或任何合约。
 valueType可以是包括另一映射或数组的任何类型。
 maps 是不可迭代的。
*/
contract Mapping {
    // Mapping from address to uint
    mapping(address => uint)public myMap;
    function get(address _addr)public view returns (uint) {
        // mapping总是返回一个值。
        // 如果从未设置该值，它将返回默认值。
        return myMap[_addr];
    }

    function set(address _addr,uint _i)public {
        // 更新address的值
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        // 将值重置为默认值。
        delete myMap[_addr];
    }

}

contract NestedMapping {
    // 嵌套映射(从地址映射到另一个映射)
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool){
        // 可以从mapping nested获得值 
        //即使未初始化
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }

}