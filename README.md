# Mycelium Hook Contract

## Overview

The Mycelium Hook Contract is a Uniswap V4 hook that intercepts swap transactions and channels their economic flow to power EVVM execution. Instead of creating artificial incentives, it leverages the natural and predictable behavior of arbitrage bots to sustain a virtual execution environment without burdening end users with gas costs.

## Purpose

This hook enables arbitrage bots to sponsor EVVM execution as a condition of accessing arbitrage opportunities. By integrating virtual execution into the swap process that bots were already going to perform, the system becomes self-sustaining through market incentives rather than external dependencies.

## Key Responsibilities

### 1. Execution Trigger
- Intercepts each swap executed by an arbitrage bot
- Triggers EVVM virtual transaction execution prior to the swap completion
- Ensures deterministic state transitions before swap settlement

### 2. State Management
- Preserves the integrity and determinism of the EVVM core

### 3. Reward Distribution
- Allocates base fees to LP positions for sustaining the execution flow
- Assigns priority fees to arbitrage bots as direct incentive for EVVM sponsorship
- Ensures users enjoy gasless interactions without additional relayers

### 4. Economic Integration
- Couples EVVM execution directly to real economic flow in the AMM
- Transforms each swap into a contribution to the execution network
- Creates a sustainable model where market volume fuels computational capacity

## Integration Points

### With Uniswap V4
- Registers as a hook on specified token pairs
- Operates within the Uniswap hook lifecycle (beforeSwap, afterSwap, etc.)
- Maintains compatibility with Uniswap's liquidity and fee mechanisms

### With EVVM Core
- Calls EVVM execution functions to process virtual transactions
- Integrates Fisher logic directly into the arbitrage flow

### With Arbitrage Bots
- Provides incentive structure through priority fees
- Couples execution sponsorship to swap execution

## Design Principles

**Alignment**: Every participant benefits—LPs receive rewards, bots improve margins, users pay no gas.

**Sustainability**: The system is powered by inevitable market activity, not artificial incentives.

**Simplicity**: No additional complexity for end users; the process is transparent and integrated directly into standard Uniswap swaps.

**Resilience**: As long as arbitrage activity exists, the system sustains itself.