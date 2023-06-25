// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
您可以通过以下方式将以太币发送到其他合约
transfer (2300 gas, throws error)
send (2300 gas, returns bool)
call (转发所有或设定gas, returns bool)

收以太币的合约必须至少具有以下功能之一
receive() external payable
fallback() external payable

receive() is called if msg.data is empty, otherwise fallback() is called.

防止重入

在调用其他合约之前更改所有状态
使用re-entrancy guard修改器
*/

contract ReceiveEther {
    /*
    调用哪个函数，fallback（）还是received（）？
            send Ether
                |
            msg.data is empty?
                / \
                yes  no
                /     \
    receive() exists?  fallback()
            /   \
            yes   no
            /      \
        receive()   fallback()
    */
    // 接收以太币的函数。msg.data 必须为空
    receive() external payable {}
    // 当 msg.data 不为空时调用回退函数
    fallback() external payable {}
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
contract SendEther {
    function sendViaTransfer(address payable _to) public payable { 
        // 不再建议使用此函数发送 Ether。
        // msg.value (uint): 与消息一起发送的以太币（wei为单位）
        _to.transfer(msg.value);
    }
    function sendViaSend(address payable _to) public payable {
        //Send返回一个指示成功或失败的布尔值。不建议将此功能用于发送以太币。
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }
    function sendViaCall(address payable _to) public payable {
        // 调用返回一个布尔值，指示成功或失败。
        // 这是当前推荐使用的方法。
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");

    }
}