// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
消息可以在链外签名，然后使用智能合约在链上进行验证。

签名验证

如何签名和验证
# 签名
1. 创建要签名的消息
2. 对消息进行哈希处理
3. 签署哈希值（链外，保密您的私钥）

# 验证
1. 从原始消息重新创建哈希值
2. 从签名和哈希中恢复签名者
3. 将恢复的签名者与声明的签名者进行比较
*/

contract VerifySignature {
    /* 1. 解锁 MetaMask 账户
    ethereum.enable()
    */
    /* 2. 获取要签名的消息哈希
    getMessageHash(
        0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C,
        123,
        "coffee and donuts",
        1
    )

    hash = "0xcf36ac4f97dc10d91fc2cbb20d718e94a8cbfe0f82eaedc6a4aa38946fb797cd"
    */
    function getMessageHash(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce
    ) public pure returns (bytes32) {
        return  keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
    }
    /* 3. 签名消息哈希
    # using browser
    account = "copy paste account of signer here"
    ethereum.request({ method: "personal_sign", params: [account, hash]}).then(console.log)

    # using web3
    web3.personal.sign(hash, web3.eth.defaultAccount, console.log)

    Signature will be different for different accounts
    0x993dab3dd91f5c6dc28e17439be475478f5635c92a56e17e82349d3fb2f166196f466c0b4e0c146f285204f0dcb13e5ae67bc33f4b888ec32dfe0a063e8f3f781b
    */
    function getEthSignedMessageHash(
        bytes32 _messageHash
    ) public pure returns (bytes32) {
        /*
        签名是通过使用以下格式签署 keccak256 哈希值来生成的：
        "\x19Ethereum Signed Message\n" + len(msg) + msg
        */
        return keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash)
        );
    }
    /* 4.验证签名
    signer = 0xB273216C05A8c0D4F0a4Dd0d7Bae1D2EfFE636dd
    to = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C
    amount = 123
    message = "coffee and donuts"
    nonce = 1
    signature =
        0x993dab3dd91f5c6dc28e17439be475478f5635c92a56e17e82349d3fb2f166196f466c0b4e0c146f285204f0dcb13e5ae67bc33f4b888ec32dfe0a063e8f3f781b
    */
    function verify(
        address _signer,
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce,
        bytes memory signature
    ) public pure returns (bool) {
        bytes32 messageHash = getMessageHash(_to, _amount, _message, _nonce);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
       return recoverSigner(ethSignedMessageHash, signature) == _signer;
    }
    function recoverSigner(
        bytes32 _ethSignedMessageHash,
         bytes memory _signature
    ) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        // ecrecover 从椭圆曲线签名中恢复出与公钥关联的地址，出错时返回零。
          return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSignature(
        bytes memory sig
    )public pure returns (bytes32 r, bytes32 s, uint8 v){
        require(sig.length == 65, "invalid signature length");
        // 汇编 更少的Gas消耗
        assembly{
            /*
            前32个字节存储签名的长度

            add(sig, 32) = pointer of sig + 32
           有效地跳过签名的前32个字节

            mload(p) 从存储器地址p开始的下一个32字节加载到存储器中
            */
            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))

        }
    }


}
