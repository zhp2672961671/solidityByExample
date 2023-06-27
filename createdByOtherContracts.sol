// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
合约可以由其他合约使用 new 关键字创建。

从0.8.0开始，new关键字通过指定salt选项支持create2功能。

*/

contract Car {
    address public owner;
    string public model;
    address public carAddr;
    constructor(address _owner, string memory _model) payable {
        owner = _owner;
        model = _model;
        carAddr = address(this);
    }
}

contract CarFactory {
    Car[] public cars;
    function create(address _owner, string memory _model) public {
        Car car = new Car(_owner, _model);
        cars.push(car);
    }
    function createAndSendEther(address _owner, string memory _model) public payable {
        Car car = (new Car){value: msg.value}(_owner, _model);
        cars.push(car);
    }
    function create2AndSendEther(
        address _owner,
        string memory _model,
        bytes32 _salt
    ) public payable {
        Car car = (new Car){value : msg.value, salt: _salt}(_owner, _model);
        cars.push(car);
    }
}