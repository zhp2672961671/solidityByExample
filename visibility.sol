// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
可访问性
函数和状态变量必须声明它们是否可以被其他合约访问。
函数可以声明为
public - 任何合约和账户都可以调用
private - 仅在定义函数的合约内
internal- 仅限继承内部函数的内部合约
external - 只有其他合约和账户可以调用
状态变量可以声明为公共、私有或内部变量，但不能声明为外部变量。
*/
contract Base {
    // 私有函数只能在这个合约内部被调用 继承这个合约的合约不能调用这个函数。
    function privateFunc() private pure returns (string memory) {
        return  "private function called";
    }
    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();
    }
    // 可以调用内部函数  - 在这个合约内部  - 在继承这个合约的合约内部
    function internalFunc() public pure returns (string memory) {
        return "internal function called";
    }
    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }
    //  公共函数可以被调用  - 在这个合约内部  - 在继承这个合约的合约内部  - 由其他合约和账户调用
    function publicFunc() public pure returns (string memory) {
        return "public function called";
    }
    // 外部函数只能被其他合约和账户调用 
    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }
    // 这个函数不会编译，因为我们试图在这里调用 一个外部函数。
    // 函数测试External Func() public pure returns (string memory) { // return external Func();
    // }
    //状态变量
    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";
    //状态变量不能外部，因此此代码不会编译。
    //  string external externalVar = "my external variable";
}
contract Child is Base {
    // 继承合约无权访问私有函数 和状态变量。
    // function testPrivateFunc() public pure returns (string memory) {
    //     return privateFunc();
    // }

    // 在子合约内部调用内部函数调用。
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }


} 
