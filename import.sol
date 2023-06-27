// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
Try Catch 只能捕获来自外部函数调用和合约创建的错误。
文件夹结构。
├── Import.sol
└── tryCatch.sol
*/

// //从当前目录导入tryCatch.sol
import "./tryCatch.sol";

// import {symbol1 as alias, symbol2} from "filename";
import {Unauthorized, add as func, Point} from "./tryCatch.sol";

// 您也可以通过复制 url 从 Github 导入
// https://github.com/AmazingAng/WTF-Solidity/blob/main/31_ERC20/ERC20.sol
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/31_ERC20/ERC20.sol";

// Example import ECDSA.sol from openzeppelin-contract repo, release-v4.5 branch
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";


contract Import {
    // 初始 tryCatch.sol
     Foo public foo = new Foo(msg.sender);

     function getFooName() public view returns (string memory) {
         return foo.name();
     }

}



