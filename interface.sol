// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
可以通过声明接口与其他合约进行交互。
Interface
不能实现任何功能
可以继承其他接口
所有声明的函数必须是外部的
不能声明构造函数
不能声明状态变量
*/

contract Counter {
    uint public count ;

    function increment() external {
        count += 1;
    }
}

interface  ICounter {
    function count() external view returns (uint);
    function incerment() external ;
}

contract myContract {
    function incermentCounter(address _counter) external {
        ICounter(_counter).incerment();
    }
    function getCount(address _counter) external view returns (uint){
        return ICounter(_counter).count();
    }
}
// Uniswap示例
interface UniswapV2Factory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);    
}

interface  UniswapV2Pair {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}
contract UniswapExample {
    address private factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    
    function getTokenReserves() external view returns (uint, uint) {
    address pair = UniswapV2Factory(factory).getPair(dai, weth);
    (uint reserve0, uint reserve1, ) = UniswapV2Pair(pair).getReserves();
    return (reserve0, reserve1);
    }
}