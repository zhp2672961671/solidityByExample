// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
Keccak256计算输入的 Keccak-256 哈希值。
一些用例包括：
根据输入创建确定性唯一 ID
提交显示方案
紧凑的加密签名（通过对哈希而不是更大的输入进行签名）
*/
contract HashFunction {
    function hash(
        string memory _text,
        uint _num,
        address _addr
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }
    //哈希冲突的示例
    //当您将多个动态数据类型
    //传递给abi.encode Packed时，可能会发生哈希冲突。在这种情况下，您应该使用abi.encode。
    function collision(
        string memory _text,
        string memory _anotherText
    ) public pure returns (bytes32,bytes32){
        // encodePacked(AAA, BBB) -> AAABBB
        // encodePacked(AA, ABBB) -> AAABBB
        return (keccak256(abi.encodePacked(_text, _anotherText)),keccak256(abi.encode(_text, _anotherText)));
    }
}
contract GuessTheMagicWord {
    bytes32 public answer =
      0x60298f78cc0b47170ba79c10aa3851d7648bd96f2f8e46a19dbc777c36fb0c00;
    // 神奇的词是"Solidity"
    function guess(string memory _word) public view returns (bool) {
        return keccak256(abi.encodePacked(_word)) == answer;
    }
}