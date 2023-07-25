// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
可升级代理合约示例。千万不要在生产中使用这个。
此示例显示
  如何使用delegatecall并在调用回退时返回数据。
  如何将管理员和实现的地址存储在特定的插槽中。
*/
// 透明的可升级代理模式

contract CounterV1 {
    uint public count;

    function inc() external {
        count += 1;
    }
}

contract CounterV2 {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}

contract BuggyProxy {
    address public implementation;
    address public admin;

    constructor() {
        //  msg.sender消息调用者 (当前调用)
        admin = msg.sender;
    }

    function _delegate() private returns (bytes calldata) {
        // call与delegatecall区别
        // 这两个方法都是进行合约之间的调用。
        // call是自己本身不发生改变，被调用的值发生改变，delegatecall是自己本身的值发生改变，被调用的不发生改变。
        //msg.data 用户发生的转账之外的内容，可以是文字备注之类的
        (bool ok, ) = implementation.delegatecall(msg.data);
         require(ok, "delegatecall failed");
        return  msg.data;
    }

    fallback() external payable {
        _delegate();
    }

    receive() external payable {
        _delegate();
    }

    function upgradeTo(address _implementation) external {
        require(msg.sender == admin,"not authorized");
        implementation = _implementation;
    }
}

contract  Dev {
    function selectors() external pure returns (bytes4, bytes4, bytes4) {
        return(
            Proxy.admin.selector,
            Proxy.implementation.selector,
            Proxy.upgradeTo.selector
        );
    }  
}

library StorageSlot {
    struct AddressSlot {
        address value;
    }
    function getAddressSlot(
        bytes32 slot
    ) internal pure returns (AddressSlot storage r){
        // 使用汇编
        //细粒度的控制
        //消耗更少的gas
        //更强的功能
        assembly {
            r.slot := slot
        }
    }
}

contract Proxy {
    //所有函数/变量都应该是私有的，将所有调用转发到fallback
    // -1 for unknown preimage
    // 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
    bytes32 private constant IMPLEMENTATION_SLOT =
        bytes32(uint(keccak256("eip1967.proxy.implementation")) - 1);
    // 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
    bytes32 private constant ADMIN_SLOT =
        bytes32(uint(keccak256("eip1967.proxy.admin")) - 1);

    constructor() {
       _setAdmin(msg.sender);
    }

    modifier ifAdmin() {
        if (msg.sender == _getAdmin()) {
            _;
        }else {
        _fallback();
        }
    }

    function _getAdmin() private view returns (address) {
        return StorageSlot.getAddressSlot(ADMIN_SLOT).value;
    }

    function _setAdmin(address _admin) private {
        require(_admin != address(0),"admin = zero address");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _admin;
    }

    function _getImplementation() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function _setImplementation(address _implementation) private {
        // address.code地址类型 Address 的代码 (可以为空)
        require(_implementation.code.length > 0, "implementation is not contract");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }
    // Admin interface //
    function changeAdmin(address _admin) external ifAdmin {
        _setAdmin(_admin);
    }
    // 0x3659cfe6
    function upgradeTo(address _admin) external ifAdmin {
        _setAdmin((_admin));
    }
    // 0xf851a440
    function admin() external ifAdmin returns (address){
        return _getAdmin();
    }
      // 0x5c60da1b
    function implementation() external ifAdmin returns (address){
         return _getImplementation();
    }

    function _delegate(address _implementation) internal virtual {
         assembly {
            //复制msg.data。我们完全控制这个内联程序集
            //块中的内存，因为它不会返回Solidity代码。我们在内存位置0处覆盖
            //Solidity暂存板。
            // calldatacopy(t, f, s) - 将s字节从位置f的calldata复制到位置t的mem
            // calldatasize() - 调用数据的大小（以字节为单位）
            calldatacopy(0, 0, calldatasize())

            // 调用实现。
            // out 和 outsize 为 0，因为我们还不知道大小。

            // delegatecall(g, a, in, insize, out, outsize) -
            // - 调用合约地址 a
            // - 带输入存储器[in…(in+insize))
            // - 提供gas g 
            // - 输出区域内存[out…(out+outsize))
            // - 出错时返回 0（例如，gas耗尽），成功时返回 1
            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

            // 复制返回的数据。
            // returndatacopy(t, f, s) - 将 s 个字节从位置 f 处的 returndata 复制到位置 t 处的 mem
            // returndatasize() - 最后返回数据的大小
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall 出错时返回 0。
            case 0 {
                //  revert(p, s) - 结束执行，恢复状态变化，返回数据 mem[p…(p+s))
                revert(0, returndatasize())
            }
            default {
                // return(p, s) - 结束执行，返回数据 mem[p…(p+s))
                return(0, returndatasize())
            }
        }
    }

    function _fallback() private {
        _delegate(_getImplementation());
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }

}

contract ProxyAdmin {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    function getProxyAdmin(address proxy) external view returns (address) {
        (bool ok, bytes memory res) = proxy.staticcall(abi.encodeCall(Proxy.admin, ()));
        require(ok, "call failed");
        return abi.decode(res, (address));
    }

    function getProxyImplementation(address proxy) external view returns (address) {
        (bool ok, bytes memory res) = proxy.staticcall(
            abi.encodeCall(Proxy.implementation, ())
        );
        require(ok, "call failed");
        return abi.decode(res, (address));
    }

    function changeProxyAdmin(address payable proxy, address admin) external onlyOwner {
        Proxy(proxy).changeAdmin(admin);
    }

    function upgrade(address payable proxy, address implementation) external onlyOwner {
        Proxy(proxy).upgradeTo(implementation);
    }
}

contract TestSlot {
    bytes32 public constant slot = keccak256("TEST_SLOT");

    function getSlot() external view returns (address) {
        return StorageSlot.getAddressSlot(slot).value;
    }

    function writeSlot(address _addr) external {
        StorageSlot.getAddressSlot(slot).value = _addr;
    }
}