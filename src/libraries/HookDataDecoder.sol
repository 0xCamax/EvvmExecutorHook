// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EvvmStructs} from "../interfaces/IEvvm.sol";

library HookDataDecoder {
    function decode(bytes memory hookData) internal pure returns (uint256, EvvmStructs.PayData[] memory) {
        return abi.decode(hookData, (uint256, EvvmStructs.PayData[]));
    }

    function getParams(EvvmStructs.PayData memory payData)
        internal
        pure
        returns (
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
        )
    {
        from = payData.from;
        to_address = payData.to_address;
        to_identity = payData.to_identity;
        token = payData.token;
        amount = payData.amount;
        priorityFee = payData.priorityFee;
        nonce = payData.nonce;
        priorityFlag = payData.priorityFlag;
        executor = payData.executor;
        signature = payData.signature;
    }
}
