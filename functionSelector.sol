// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
调用函数时，calldata 的前 4 个字节指定要调用哪个函数。
这4个字节称为函数选择器。
以下面这段代码为例。
它使用 call 在地址 addr 处的合约上执行转账。
addr.call(abi.encodeWithSignature("transfer(address,uint256)", 0xSomeAddress, 123))
abi.encode With Signature(....) 返回的前 4 个字节是函数选择器。
如果您在代码中预先计算并内联函数选择器，也许您可​​以节省少量的gas？
以下是函数选择器的计算方式。
*/

contract functionSelector {
    /*
    "transfer(address,uint256)"
    0xa9059cbb
    "transferFrom(address,address,uint256)"
    0x23b872dd
    */
    function getSelector(string calldata _func) external  pure returns (bytes4) {
        // keccak256(bytes memory) returns (bytes32): 计算输入参数的 Keccak-256 哈希
        return bytes4(keccak256(bytes(_func)));
    }

}
