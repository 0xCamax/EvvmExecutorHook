// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEvvm} from "../interfaces/IEvvm.sol";

abstract contract EvvmRegistry {
    address internal owner;
    mapping(uint256 => IEvvm) public evvm;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(address _owner) {
        owner = _owner;
    }

    function addEvvm(address _evvm) public onlyOwner {
        IEvvm __evvm = IEvvm(_evvm);
        uint256 id = __evvm.getEvvmID();
        evvm[id] = __evvm;
    }
}
