// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
Try Catch 只能捕获来自外部函数调用和合约创建的错误。

*/
struct Point {
    uint x;
    uint y;
}

error Unauthorized(address caller);

function add(uint x, uint y) pure returns (uint) {
    return x + y;
}
contract Foo {
    string public name = "Foo";
    address public owner;
    constructor(address _owner) {
        require(_owner != address(0), "invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }
    function myFunc(uint x) public view  returns (string memory, address ) {
        require(x!=0, "require failed");
        return ("my func was called", owner );
    }
}
contract Bar {
    event Log(string message);
    event LogBytes(bytes data);
    Foo public foo;
    constructor(){
        // 此 Foo 合约用于使用外部调用进行 try catch 的示例
        foo = new Foo(msg.sender);
    }
    // try / catch 与外部调用的示例
    // tryCatchExternalCall(0) => Log("external call failed")
    // tryCatchExternalCall(1) => Log("my func was called")
    function tryCatchExternalCall(uint _i) public {
        try foo.myFunc(_i) returns (string memory result,address) {
            emit Log(result);
        } catch {
            emit Log("external call failed");
        }
    }
    // 使用 try/catch 创建合约的示例
    // tryCatchNewContract(0x0000000000000000000000000000000000000000) => Log("invalid address")
    // tryCatchNewContract(0x0000000000000000000000000000000000000001) => LogBytes("")
    // tryCatchNewContract(0x0000000000000000000000000000000000000002) => Log("Foo created")
    function tryCatchNewContract(address _owner) public {
        try new Foo(_owner) returns (Foo foo1) {
            // 你可以在这里使用变量 foo1
            emit Log("Foo created");
            foo1.myFunc(1);
        } catch Error(string memory reason) {
            //catch失败的revert（）和require（）
            emit Log(reason);
        } catch (bytes memory reason1) {
            //  catch failing assert()
            emit LogBytes(reason1);
        }
    }

}

