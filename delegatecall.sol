// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
delegatecall是一个类似于call的低级函数。
当合约A执行对合约B的委托调用时，B的代码将使用合约A的存储、msg.sender和msg.value执行
*/

// 注意：首先部署此合约

contract B {
    // 注意：存储布局必须与合约A相同
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}
contract A {
    uint public num;
    address public sender;
    int public value;

    function setVars(address _contract, uint _num) public payable {
        // A的存储已设置，B未修改。
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        ) ;
    }


}