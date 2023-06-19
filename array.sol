// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
Array可以具有编译时固定大小或动态大小。
*/

contract Array {
    // 初始化数组的几种方法
    uint[] public arr;
    uint[] public arr2 = [1,2,3];
    // 固定长度的数组，所有元素初始化为 0
    uint[10] public myFixedSizeArr ;

    function get(uint _i ) public view returns (uint) {
        return arr[_i];
    }
    //Solidity可以返回整个数组。
    //但应避免使用此功能
    // 长度可以无限增长的数组。
    function getArr() public view returns (uint[] memory) {
        return arr ;
    }

    function push (uint _i) public {
        //添加到数组
        // 这会将数组长度增加 1
        arr.push(_i);
    }

    function pop() public {
        // 从数组中删除最后一个元素   这会将数组长度减 1
        arr.pop();
    }

    function getLength() public view returns (uint) {
        return arr.length;
    }

    function remove (uint _index) public {
        //Delete不会更改数组长度。它将索引处的值重置为默认值，在本例中为0
        delete arr[_index];
    }
    // external 只能在合约之外调用 - 它们不能被合约内的其他函数调用。
    function examples() external {
        // 在内存中创建数组，只能创建固定大小
        //memory 函数内部声明的变量，即局部变量 内存中，运行完之后销毁 单个节点 值传递
        // storage 函数外部声明的变量，即状态变量  区块链上，永久存在   区块链网络上  指针传递
        uint[] memory a = new uint[](5);
    }

}

/*
通过从右向左移动元素来删除数组元素
*/

contract ArrayRemoveByShifting {
    // [1, 2, 3] -- remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1, 2, 3, 4, 5, 6] -- remove(0) --> [2, 3, 4, 5, 6, 6] --> [2, 3, 4, 5, 6]
    // [1] -- remove(0) --> [1] --> []
    uint[] public arr;
    function remove(uint _index) public {
        //require  如果条件为 false ， 终止执行并回退状态改变 (用于检查错误输入，或外部组件的错误)
        require(_index < arr.length, "index out of bound");
        for (uint i = _index; i < arr.length -1 ; i++){
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1,2,3,4,5];
        remove(2);
        //[1,2,3,4,5]
        //assert 如果条件为 false ， 终止执行并回退状态改变 (用于内部错误)
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);
        //[];
        assert(arr.length == 0);
    }
}

/*
通过将最后一个元素复制到要删除的位置来删除数组元素
*/

contract ArrayReplaceFromEnd {
    uint[] public arr ;
    //删除元素会在阵列中产生间隙。 保持数组紧凑的一个技巧是  将最后一个元素移动到要删除的位置。
    function remove(uint _index) public {
        //将最后一个元素移至删除位置
        arr[_index] = arr[arr.length -1];
        // 删除最后一个元素
        arr.pop();
    }

    function test() public {
        arr = [1,2,3,4];
        remove(1);
        //[1,4,3}
        assert(arr.length ==3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        //[1,4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }

}

