// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {BaseHook, PoolKey, SwapParams, BeforeSwapDelta, BalanceDelta} from "./contracts/BaseHook.sol";
import {toBeforeSwapDelta} from "@uniswap/v4-core/src/types/BeforeSwapDelta.sol";
import {EvvmRegistry} from "./contracts/EvvmRegistry.sol";
import {EvvmStructs, IEvvm} from "./interfaces/IEvvm.sol";
import {HookDataDecoder} from "./libraries/HookDataDecoder.sol";

contract EvvmExecutorHook is BaseHook, EvvmRegistry {
    /* 
        TODO:
        - MUST take hookData and execute to de EVVM
        - MUST donate rewards to the LPs
        - Validate hookData ?
    */

    error NoEvvmTransaction();

    constructor(address _owner, address _poolManager) BaseHook(_poolManager) EvvmRegistry(_owner) {}

    function _beforeSwap(
        address, /*sender*/
        PoolKey calldata, /*key*/
        SwapParams calldata, /*params*/
        bytes calldata hookData
    ) internal override returns (bytes4, BeforeSwapDelta, uint24) {
        /* 
            hookData is a EVVM transaction array
            - MUST batch execute to de EVVM
            - Check if is service or normal tx
        */

        if (hookData.length == 0) {
            revert NoEvvmTransaction();
        }

        (uint256 evvmId, EvvmStructs.PayData[] memory txArray) = HookDataDecoder.decode(hookData);
        IEvvm _evvm = evvm[evvmId];

        for (uint256 i = 0; i < txArray.length; i++) {
            (
                address from,
                address to_address,
                string memory to_identity,
                address token,
                uint256 amount,
                uint256 priorityFee,
                uint256 nonce,
                bool priorityFlag,
                address executor,
                bytes memory signature
            ) = HookDataDecoder.getParams(txArray[i]);

            _evvm.pay(
                from, to_address, to_identity, token, amount, priorityFee, nonce, priorityFlag, executor, signature
            );
        }

        return (this.beforeSwap.selector, toBeforeSwapDelta(0, 0), 0);
    }
}
