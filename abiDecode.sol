// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
abi.encode 将数据编码为字节。
abi.decode 将字节解码回数据。
*/
// ["123",[1,2,3]]
contract AbiDecode {
    struct MyStruct {
        string name;
        uint[2] nums;
    }
    function encode(
        uint x,
        address addr,
        uint[] calldata arr
        ,
        MyStruct calldata myStruct
    ) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, myStruct);
    }
    function decode(
        bytes calldata data
    )external pure returns
    (uint x, address addr, uint[] memory arr, MyStruct memory myStruct)
    {
        (x, addr, arr, myStruct) = abi.decode(data, (uint, address, uint[], MyStruct));
    }
}