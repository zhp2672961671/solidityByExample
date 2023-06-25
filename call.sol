// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
call 是与其他合约交互的低级函数。
当您只是通过调用fallback函数发送 Ether 时，建议使用此方法。
然而，这不是调用现有函数的推荐方法。
不推荐低级调用的几个原因
Reverts 不会冒泡
类型检查被绕过
省略了功能存在性检查
*/
contract Receiver {
    event Received(address caller, uint amount, string message);
    fallback() external payable {
        emit Received(msg.sender, msg.value,"Fallback was called" );
    }
    receive() external payable {
       emit Received(msg.sender, msg.value,"receive was called" );
    }
    function foo(string memory _message, uint  _x) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);
        return _x + 1;
    }
}

contract Caller {
    event Response(bool succes, bytes data);
    // 假设合约调用方没有合约接收方的源代码，但我们知道合约接收方的地址和要调用的函数。
    function testCallFoo(address payable _addr) public payable {
        //  您可以发送以太币并指定自定义gas
        (bool success, bytes memory data) = _addr.call{value: msg.value, gas:5000}(
              abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );
        emit Response(success, data);
    }
    // 调用不存在的函数会触发fallback函数。
    function testCallDoesNotExist(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("doesNotExist()")
        );

        emit Response(success, data);
    }

}

