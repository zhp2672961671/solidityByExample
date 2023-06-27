// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
库与合约类似，但你不能声明任何状态变量，也不能发送以太币。
如果所有库函数都是内部的，则库将嵌入到合约中。
否则，必须在部署合约之前部署并链接库。
*/
library Math {
    function sqrt(uint y) internal pure returns (uint z) {
        if(y >3) {
            z =y ;
            uint x = y /2 +1;
            while (x <z) {
                z = x ;
                x = (y / x + x) / 2;
            }
        }else if (y !=0) {
            z = 1;
        }
    }
}

contract TestMath {
    function testSquareRoot(uint x) public pure returns (uint) {
        return Math.sqrt(x);
    }
}
//数组函数删除索引处的元素并重新组织数组 使元素之间没有间隙。
library Array {
    function remove(uint[] storage arr, uint index) public {
        // //将最后一个元素移动到要删除的位置
        require(arr.length > 0,  "Can't remove from empty array");
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}
contract TestArray {
    using Array for uint[];
    uint[] public arr;
    function testArrayRemove() public {
        for(uint i = 0; i < 3; i++) {
            arr.push(i);
        }
        arr.remove(1);

        assert(arr.length == 2);
        assert(arr[0] == 0);
        assert(arr[1] == 2);
    }
}