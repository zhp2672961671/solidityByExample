// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
Solidity 支持多重继承。合约可以使用 is 关键字继承其他合约。
将被子合约覆盖的函数必须声明为virtual。
要覆盖父函数的函数必须使用关键字 override。
继承顺序很重要。
您必须按照从“最基础”到“最衍生”的顺序​​列出父合约。
*/

/* 继承图
    A
   / \
  B   C
 / \ /
F  D,E

*/

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}
// 合约通过使用关键字“is”继承其他合约。
contract B is A {
    // 覆盖A.foo（）
    function foo() public pure virtual override returns (string memory){
        return "B";
    }
}
contract C is A {
      // 覆盖A.foo（）
      function foo() public pure virtual override returns (string memory) {
          return "C";
      }
}
// 合约可以继承多个父合约。
// 当调用在不同合约中多次定义的函数时，将从右到左以深度优先的方式搜索父合约。

contract D is C, B {
    // D.foo() returns "C"
    function foo() public pure override (B, C) returns (string memory) {
        return super.foo();
    }

}
contract E is B, C {
    // E.foo() returns "B"
    // 因为B是函数foo（）的最右边的父合约
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}
// 继承必须从“最类基”到“最派生”排序。
// 调换 A 和 B 的顺序会抛出编译错误。

contract F is A, B {
    function foo() public pure override (A, B) returns (string memory) {
         return super.foo();
    }
}


