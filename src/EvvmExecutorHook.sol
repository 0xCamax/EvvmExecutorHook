// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {BaseHook} from "@openzeppelin/uniswap-hooks/src/base/BaseHook.sol";
import {Immutables} from "./contracts/Immutables.sol";
import {EvvmStructs} from "./interfaces/IEvvm.sol";

contract EvvmExecutorHook is BaseHook, Immutables {
    /* 
        TODO:
        - MUST take hookData and execute to de EVVM
        - MUST donate rewards to the LPs
        - Validate hookData ?
    */

    function _beforeSwap(address sender, PoolKey calldata key, SwapParams calldata params, bytes calldata hookData)
        internal
        override
        returns (bytes4, BeforeSwapDelta, uint24)
    {

        

        /* 
            hookData is a EVVM transaction array
            - MUST batch execute to de EVVM
            - Check if is service or normal tx
         */
    }
}
