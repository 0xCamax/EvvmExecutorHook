// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/EvvmExecutorHook.sol";
import "../src/utils/Constants.sol";
import {HookMiner} from "@uniswap/v4-periphery/src/utils/HookMiner.sol";
import {Hooks, IHooks} from "@uniswap/v4-core/src/libraries/Hooks.sol";
import {Helpers} from "./Helpers.s.sol";

import {Script, console} from "forge-std/Script.sol";

contract Deployment is Script, ArbitrumConstants, Helpers {
    EvvmExecutorHook internal evvmExecutor;
    uint256 internal deployerPrivateKey;

    function setUp() public {
        deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    }

    function run() public {
        vm.startBroadcast();
        evvmExecutor = _deploy(DEV);

        console.log(address(evvmExecutor));

        vm.stopBroadcast();
    }
}
