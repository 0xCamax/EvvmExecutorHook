// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/FloVVMExecutorHook.sol";
import "../src/utils/Constants.sol";
import {HookMiner} from "@uniswap/v4-periphery/src/utils/HookMiner.sol";
import {Hooks, IHooks} from "@uniswap/v4-core/src/libraries/Hooks.sol";
import {Helpers} from "./Helpers.s.sol";

import {Script, console} from "forge-std/Script.sol";

contract Deployment is Script, ArbitrumConstants, Helpers {
    FloVVMExecutorHook internal evvmExecutor;
    uint256 internal deployerPrivateKey;

    function setUp() public {
        deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        console.log("FloVVM address", address(FloVVM));
    }

    function run() public {
        vm.startBroadcast(deployerPrivateKey);

        evvmExecutor = _deploy(DEV);
        _setupApprovals(address(evvmExecutor));
        _configurePoolKeys(1000, 1, address(evvmExecutor));
        _initializePool();
        evvmExecutor.addEvvm(address(FloVVM));
        console.log("Hook address", address(evvmExecutor));

        vm.stopBroadcast();
    }
}
