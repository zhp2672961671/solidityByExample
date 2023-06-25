// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
声明payable的函数和地址可以将以太币接收到合约中。
*/
contract Payable {
    // Payable 地址可以接收  Ether
    address payable public owner;

    // Payable 构造函数可以接收 Ether
    constructor() payable {
        owner = payable (msg.sender);
    }
    // 将以太币存入此合约的函数。
    // 与一些以太一起调用这个函数。
    // 该合约的余额会自动更新。
    function deposit() public payable {}
    // 与一些以太一起调用这个函数。
    // 该函数将抛出一个错误，因为该函数是不可支付的。
    function notPayable() public {}
    // 从该合约中提取所有以太币的函数。
    function withdraw() public {
        // 获取该合约中存储的以太币数量
        uint amount = address(this).balance;
        // 将所有以太币发送给所有者 
        // 所有者可以接收以太币，因为所有者的地址是可支付的
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }
    // 将以太币从该合约转移到输入地址的函数
    function transfer(address payable _to, uint _amount) public {
        // 注意“_to”被声明为payable
         (bool success, ) = _to.call{value: _amount}("");
         require(success, "Failed to send Ether");
    }

}