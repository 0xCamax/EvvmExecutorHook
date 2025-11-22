// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/FloVVMExecutorHook.sol";
import {Helpers} from "../script/Helpers.s.sol";

contract MainTests is Test, Helpers {
    FloVVMExecutorHook public FloVVMExecutor;

    address testAccount;
    address fisher;

    function setUp() public {
        vm.createSelectFork("arbitrum");
        testAccount = address(this);
        _fundAccount(testAccount);
        FloVVMExecutor = _deploy(testAccount);
        fisher = DEV;

        _fundAccount(address(DEV));

        _configurePoolKeys(1000, 1, address(FloVVMExecutor));
        _setupApprovals(address(FloVVMExecutor));
        _initializePool();
        _addLiquidity(10_000_000);

        FloVVM.addBalance(DEV, address(USDC), 1000_000_000);

        FloVVMExecutor.addEvvm(address(FloVVM));
        console.log("FloVVM address", address(FloVVM));
        console.log("Hook address", address(FloVVMExecutor));
    }

    function test_transactionExecution() public {
        //Revert because no transaction passed to the hook
        vm.expectRevert();
        _swap(10_000, true, "");

        // struct PayData {
        //     address from;
        //     address to_address;
        //     string to_identity;
        //     address token;
        //     uint256 amount;
        //     uint256 priorityFee;
        //     uint256 nonce;
        //     bool priorityFlag;
        //     address executor;
        //     bytes signature;
        // }

        console.log("User Balance: ", FloVVM.getBalance(0xEC08EfF77496601BE56c11028A516366DbF03F13, address(USDC)));

        EvvmStructs.PayData[] memory txArray = new EvvmStructs.PayData[](1);
        txArray[0] = EvvmStructs.PayData(
            DEV,
            0xEC08EfF77496601BE56c11028A516366DbF03F13,
            "",
            address(USDC),
            10,
            0,
            0,
            false,
            address(0),
            hex"4d05533cdfb761d084b0061f91f5e15f51fe4864d72db6ab1e2e344bb5b858be417492aba7c8a235353e303df6db98117eb48a57945f2e4bfaf783b9cbede2de1c"
        );

        bytes memory hookData = abi.encode(FloVVM.getEvvmID(), txArray);

        _swap(10_000, true, hookData);

        console.log("User Balance: ", FloVVM.getBalance(0xEC08EfF77496601BE56c11028A516366DbF03F13, address(USDC)));
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
