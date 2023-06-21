// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
构造函数是在合约创建时执行的可选函数。
以下是如何将参数传递给构造函数的示例。
*/
// 基础合约 X
contract X {
    string public name;
    constructor(string memory _name) {
        name = _name;
    }
}
// 基础合约 Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}
//有两种方法可以使用参数初始化父合约。
//在继承列表中的此处传递参数。
contract B is X("Input to X"),  Y ("Input to Y") {

}

contract C is X,Y {
    //在构造函数中传递参数，//类似于函数修改器。
    constructor(string memory _name,string memory _text) X(_name) Y(_text){
        
    }
}
//父构造函数总是按继承/的顺序调用，而不管子约定的构造函数中列出的父约定的顺序如何。
// 构造函数的调用顺序：
// 1. X
// 2. Y
// 3. D

contract D is X,Y {
    constructor() X("X was called") Y("Y was called") {}
}
// 构造函数的调用顺序：
// 1. X
// 2. Y
// 3. E
contract E is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}