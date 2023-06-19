// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
solidity支持循环语句for、while和do-while。
*/
contract Loop {
    function loop() public {
        // for 循环
        for (uint i =0 ; i< 10; i++) {
            if(i == 3){
                // 用continue跳到下一次迭代
                continue;
            }
            if(i ==5){
                // 使用 break 退出循环
                break;
            }
        }
        // while 循环
        uint j;
        while (j <10) {
            j++;
        }
        
    }
}