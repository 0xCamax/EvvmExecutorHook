// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/EvvmExecutorHook.sol";
import {Helpers} from "../script/Helpers.s.sol";

contract MainTests is Test, Helpers {
    EvvmExecutorHook public evvmExecutor;

    address testAccount;
    address fisher;

    function setUp() public {
        vm.createSelectFork("arbitrum");
        testAccount = address(this);
        _fundAccount(testAccount);
        evvmExecutor = _deploy(testAccount);
        fisher = DEV;

        _fundAccount(address(DEV));

        _configurePoolKeys(1000, 1, address(evvmExecutor));
        _setupApprovals(address(evvmExecutor));
        _initializePool();
        _addLiquidity(10_000_000);

        evvmExecutor.addEvvm(address(EVVM));
    }

    function _fundAccount(address account) public {
        vm.deal(account, 1000 ether);

        vm.startPrank(WHALE);
        uint256 usdcAmount = 10_000_000 * 1e6;
        require(USDC.balanceOf(WHALE) >= usdcAmount, "Whale has insufficient USDC");
        USDC.transfer(testAccount, usdcAmount);
        vm.stopPrank();
    }
}
