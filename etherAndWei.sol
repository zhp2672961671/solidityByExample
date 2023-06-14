// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
交易是用ether支付的。类似于一美元等于100美分，一ether等于10^18 wei。
*/
contract EtherUnits {
    uint public oneWei = 1 wei;
    // 1 wei is equal to 1
    bool public isOneWei = 1 wei == 1;
    uint public oneEther = 1 ether;
    // 1 ether is equal to 10^18 wei
    bool public isOneEther = 1 ether == 1e18;
    function getBools() public  view returns(bool, bool){
        return (isOneWei, isOneEther);
    }
}