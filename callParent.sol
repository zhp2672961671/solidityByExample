// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
调用父合约
可以直接调用父合约，也可以使用关键字 super 调用。
通过使用关键字 super，将调用所有直接父合约。
*/
/* 继承树
   A
 /  \
B   C
 \ /
  D
*/

contract A {
    // 这称为事件。您可以从您的函数中发出事件 // 它们会被记录到事务日志中。// 在我们的例子中，这对于跟踪函数调用很有用。
    event Log(string message);
    function foo() public virtual {
        emit Log("A foo called");
    }
    function bar() public virtual {
        emit Log("A.bar  called");
    }

}

contract B is A {
    function foo() public virtual override {
    emit Log("B foo called");
    A.foo();
    }
    function bar() public virtual override {
    emit Log("B bar called");
    super.bar();
    }
}
contract C is A {
    function foo() public virtual override {
        emit Log("C.foo called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar called");
        super.bar();
    }
}


contract D is B, C {
    // - 调用 D.foo 并检查事务日志。
    // 尽管 D 继承了 A、B 和 C，但它只调用了 C，然后又调用了 A。 
    // - 调用 D.bar 并检查事务日志 
    // D 调用了 C，然后是 B，最后是 A。 // 尽管调用了 super两次（由 B 和 C）只调用 A 一次。
    function foo() public override(B, C) {
    super.foo();
    }

    function bar() public override(B, C) {
        super.bar();
    }
}



