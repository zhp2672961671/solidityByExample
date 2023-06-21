// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;

/*
错误将撤消事务期间对状态所做的所有更改。
可以通过调用 require、revert 或 assert 来抛出错误。
require 用于在执行前验证输入和条件。
revert类似于require。检查的条件很复杂时 更适用。
assert用于检查不应该为false的代码。断言失败可能意味着存在错误。
使用自定义错误来节省gas。
*/

contract Error {
    function testRequire(uint _i) public pure {
        // Require 应用于验证条件，例如： 输入 执行前的条件  调用其他函数的返回值
        require(_i > 10, "Input must be greater than 10");
    }
    function testRevert(uint _i) public pure {
        // 当要检查的条件很复杂时，Revert 很有用。
        // 这段代码做的事情和上面的例子完全一样
        if(_i< 10){
            revert("Input must be greater than 10");
        }
    }

    uint public num;
    function testAssert() public view {
        // assert应该只用于测试内部错误，
        // 和检查不变量。
        // 这里我们assert num 总是等于 0 
        // 因为不可能更新 num 的值
        assert(num == 0);
    }
    //自定义错误
    error InsufficientBalance(uint balance, uint withdrawAmount);

    function testCustomError(uint _withdrawAmount) public view {
        // 地址类型 Address 的余额，以 wei 为单位
        uint bal = address(this).balance;
        if(bal < _withdrawAmount) {
            revert InsufficientBalance({balance : bal, withdrawAmount : _withdrawAmount});
        }
    } 

}
contract Account {
    uint public balance;
    uint public constant MAX_UINT = 2 **256 - 1;
    function daposit(uint _amount) public {
        uint oldBalance = balance;
        uint newBalance = balance + _amount;
        require(newBalance >= oldBalance,"Overflow");
        balance = newBalance;
        assert(balance >= oldBalance);
    }
    function withdraw(uint _amount) public {
        uint oldBalance = balance;
        require(balance >= _amount,"Underflow" );
        if(balance < _amount){
            revert("Underflow");
        }
        balance -= _amount;
        assert(balance <= oldBalance);
    }
}

