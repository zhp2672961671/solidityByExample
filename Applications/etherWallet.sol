// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
基本钱包的一个例子。
任何人都可以发送 ETH。
只有所有者才能撤回。
*/

contract EtherWallet {
    address payable public owner;
    constructor() {
        owner = payable(msg.sender);
    }
    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable (msg.sender).transfer(_amount);
    }
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}