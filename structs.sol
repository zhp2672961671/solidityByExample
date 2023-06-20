// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

import "./enum.sol";
/*
可以通过创建Struct来定义自己的类型。它们可用于将相关数据分组在一起。结构可以在合同之外声明，也可以在另一个合同中导入。
*/

contract Todos  {
    struct Todo {
        string text;
        bool completed;
    }

    //An array of 'Todo' structs

    Todo[] public todos;
    /*
    1. memory ： (内存) 即数据在内存中，因此数据仅在其生命周期内（函数调用期间）有效。

    2. storage：（链上存储空间），就是状态变量保存的位置，只要合约存在就一直存储．

    3. calldata：（调用数据），一个特殊只读数据位置，用来保存函数调用参数（之前仅针对外部函数）。
    */
    function create(string calldata _text) public {
        // 初始化结构的 3 种方法    - 像函数一样调用它
        todos.push(Todo(_text, false));
        //键值映射
        todos.push(Todo({text: _text, completed: false}));
        //初始化一个空结构，然后更新它
        Todo memory todo;
        todo.text = _text;
        //todo.completed 初始化为 false

        todos.push(todo);
    }
    
    //Solidity自动为“todos”创建了一个getter，所以  并不需要这个函数。
    function get(uint _index) public view returns (string memory _text, bool _completed){
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }
    //更新text;
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }
    //更新 completed 
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed=!todo.completed;
    }

}

contract Todos1 {
      Todo1[] public todos1;
}