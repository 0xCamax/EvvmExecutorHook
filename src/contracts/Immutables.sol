// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEvvm} from "../interfaces/IEvvm.sol";

abstract contract Immutables {
    
    IEvvm public EVVM;

    constructor(address _evvm) {
        EVVM = IEvvm(_evvm);
    }
}