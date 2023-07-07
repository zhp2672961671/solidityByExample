// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
让我们创建一个多重签名钱包。
这是规格

钱包拥有者可以
提交交易
批准和撤销批准待处理交易
在足够多的所有者批准后，任何人都可以执行交易
*/

contract MultSigWallet {
    //indexed 对于事件参数：将参数存储为主题。
    event Deposit(address indexed sender, uint amount, uint balance);
    event SubmitTransaction(
        address indexed owner,
        uint indexed txIndex,
        address indexed to,
        uint value,
        bytes data
    );
    event ConfirmTransaction(address indexed owner, uint indexed txIndex);
    event RevokeConfirmation(address indexed owner, uint indexed txIndex);
    event ExecuteTransaction(address indexed owner, uint indexed txIndex);

    address[] public owners;
    mapping(address => bool) public isOwner;
    // 需要确认num个
    uint public numConfirmationsRequired;
    struct Transaction {
        address to;
        uint value;
        bytes data;
        // 是否执行
        bool executed;
        // 确认数
        uint numConfirmations;
    }
     // mapping from tx index => owner => bool
     mapping(uint => mapping(address => bool)) public isConfirmed;
     Transaction[] public transactions;
    // 拥有者验证
     modifier onlyOwner() {
         require(isOwner[msg.sender],"not owner");
         _;
     }
    //  交易是否存在
     modifier txExists(uint _txIndex) {
         require(_txIndex < transactions.length, "tx does not exist" );
         _;
     }
    //是否未执行
     modifier notExecuted(uint _txIndex) {
         require(!transactions[_txIndex].executed,"tx already executed");
         _;
     }
    // 是否未确认
     modifier notConfirmed(uint _txIndex) {
         require(!isConfirmed[_txIndex][msg.sender],"tx already confirmed");
         _;
     }

     constructor(address[] memory _owners, uint _numConfirmationsRequired) {
        // 拥有者必须大于0
         require(_owners.length >0 ,"owners required");
        //  需要确认num大于0,小于等于拥有者数量
         require(
             _numConfirmationsRequired > 0 &&
             _numConfirmationsRequired <= _owners.length,
             "invalid number of required confirmations"
         );
         for (uint i = 0; i < _owners.length; i++){
         address owner = _owners[i];
        // 排除自身
         require(owner != address(0), "invalid owner");
         isOwner[owner] = true;
         owners.push(owner);
        }
        numConfirmationsRequired = _numConfirmationsRequired;
     }
     receive() external  payable {
         emit Deposit(msg.sender, msg.value, address(this).balance);
     }
    //  提交交易
     function submitTransaction(
         address _to,
         uint _value,
         bytes memory _data
     ) public onlyOwner {
         uint txIndex = transactions.length;
         transactions.push(
             Transaction({
                 to: _to,
                 value: _value,
                 data: _data,
                 executed:false,
                 numConfirmations : 0
             })
         );
        emit SubmitTransaction(msg.sender, txIndex, _to, _value, _data);

     }
    //确认交易
     function confirmTransaction(
         uint _txIndex
     ) public onlyOwner txExists(_txIndex) notExecuted(_txIndex) notConfirmed(_txIndex) {
         Transaction storage transaction = transactions[_txIndex];
         transaction.numConfirmations += 1;
         isConfirmed[_txIndex][msg.sender] = true;

         emit ConfirmTransaction(msg.sender, _txIndex);

     }
    //  执行事务
    function executetransaction(
        uint _txIndex
    ) public onlyOwner txExists(_txIndex) notExecuted(_txIndex) {
        Transaction storage transaction = transactions[_txIndex];
        require(
            transaction.numConfirmations >= numConfirmationsRequired,
            "cannot execute tx"
        );
        transaction.executed = true;
        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success, "tx failed");

        emit ExecuteTransaction(msg.sender, _txIndex);
    }
    // 撤销确认
    function revokeConfirmation(
         uint _txIndex
    )public onlyOwner txExists(_txIndex) notExecuted(_txIndex) {
        Transaction storage transaction = transactions[_txIndex];
        require(isConfirmed[_txIndex][msg.sender], "tx not confirmed");

        transaction.numConfirmations -= 1;
        isConfirmed[_txIndex][msg.sender] = false;

        emit RevokeConfirmation(msg.sender, _txIndex);
    }

    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    function getTransactionCount() public view returns (uint) {
        return transactions.length;
    }

    function getTransaction(
        uint _txIndex
    )
        public
        view
        returns (
            address to,
            uint value,
            bytes memory data,
            bool executed,
            uint numConfirmations
        )
    {
        Transaction storage transaction = transactions[_txIndex];

        return (
            transaction.to,
            transaction.value,
            transaction.data,
            transaction.executed,
            transaction.numConfirmations
        );
    }

}
// 这是一个测试从多重签名钱包发送交易的合约
contract TestContract {
    uint public i;
    function callMe(uint j) public {
        i += j;
    }
    function getData() public pure returns (bytes memory) {
        return  abi.encodeWithSignature("callMe(uint256)", 123);
    }
}

