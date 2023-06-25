// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
fallback 是一个特殊函数，在以下情况下执行
调用不存在的函数
以太直接发送到合约，但 receive() 不存在或 msg.data 不为空

当通过转账或发送调用时，fallback的 Gas 限制为 2300。
*/

contract Fallback {
    event Log(string func, uint gas);
    // fallback函数必须声明为外部函数。
    fallback() external payable {
        // 发送/传输（将 2300 Gas 转发到此fallback函数） 调用（转发所有 Gas）
        // gasleft() returns (uint256): 剩余 gas
        emit Log("fallback",gasleft() );

    }
    // Receive 是fallback的一种变体，当 msg.data 为空时触发
    receive() external payable {
       emit Log("receive", gasleft());
    }
    // 检查合约余额的辅助函数
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);

    }
    function callFallback(address payable _to) public payable {
        (bool sent, ) = _to.call{value : msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
// fallback 可以选择使用 bytes作为输入和输出
// TestFallbackInputOutput -> FallbackInputOutput -> Counter
contract FallbackInputOutput {
    // immutable 对于状态变量：仅允许在构造时进行一次赋值，并且之后保持不变。存储在代码中。
    address immutable target;
    constructor(address _target) {
        target = _target;
    }

    fallback(bytes calldata data) external payable returns (bytes memory) {
        (bool ok , bytes memory res) = target.call{value: msg.value}(data);
        require(ok, "call failed");
        return res;
    }

}
contract Counter {
    uint public count;
    function get() external view returns (uint) {
        return count;
    }
    function inc() external returns (uint) {
        count +=1;
        return count;
    }
}
contract TestFallbackInputOutput {
    event Log(bytes res);
    function test(address _fallback, bytes calldata data) external {
        (bool ok, bytes memory res) = _fallback.call(data);
        require(ok, "call failed");
        emit Log(res);
    }
    // abi.encodeCall(function functionPointer, (...)) returns (bytes memory): 对 functionPointer 指向的函数调用及元组中的参数进行编码，
    // 执行完整的类型检查，确保类型与函数签名相符。结果等于 abi.encodeWithSelector(functionPointer.selector, (...))
    // abi.encodeWithSelector(bytes4 selector, ...) returns (bytes memory): ABI- 为给定的 4 字节选择器和随后的参数进行编码。
    function getTestData() external pure returns (bytes memory,bytes memory) {
        return (abi.encodeCall(Counter.get,()),abi.encodeCall(Counter.inc, ()));
    }
}