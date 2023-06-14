// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
一笔交易需要支付多少以太币？
你支付的汽油费*汽油价格的以太币，其中
gas 是计算单位
gas spent 选择交易中使用的gas总量
gas price 是你愿意为每 gas 支付多少以太币
gas 价格较高的交易有较高的优先级被包含在一个区块中。
未使用的gas将被退还。

gas 限制

你可以花费的gas有两个上限
gas limit（您愿意用于交易的最大gas量，由您设定）
block gas limit（区块中允许的最大gas量，由网络设置）
*/

contract Gas {
    uint public i =0;
    // 用完你发送的所有gas会导致你的交易失败。 状态更改被撤消。消耗的gas不予退还。
    function forever() public {
        // 在这里我们运行一个循环，直到所有的gas都用完  交易失败
        while (true){
            i +=1;
        }
    }
}