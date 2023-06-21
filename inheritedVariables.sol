// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
继承的状态变量
与函数不同，状态变量不能通过在子合约中重新声明来覆盖。
让我们学习如何正确覆盖继承的状态变量。
*/

contract A {
    string public name = "contract A";

    function getName() public view returns (string memory) {
        return name;
    }

}
// Solidity 0.6 中不允许隐藏  这不会编译
// contract B is A {
//     string public name = "Contract B";
// }
contract C is A {
    constructor() {
        name = "Contract C";
    }
    // C.getName returns "Contract C"
}