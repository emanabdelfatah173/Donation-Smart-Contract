# Donation Smart Contract

A simple and transparent Ethereum smart contract written in Solidity for accepting and managing donations on the Ethereum blockchain..

## Features

- Accepts donations via function call or direct ETH transfer.
- Tracks total donations and stores donor data (address, amount, timestamp).
- Displays number of donors and total funds.
- Allows only the contract owner to withdraw funds (all or partial).
- Emits events for every donation and withdrawal for better transparency.

## Tech Stack

- Solidity 0.8.0
- Ethereum Blockchain (EVM)

## Functions Overview

| Function | Description |
|----------|-------------|
| `donate()` | Accept donations |
| `receive()` | Accept direct ETH transfers |
| `getDonorsCount()` | Returns total number of donors |
| `withdraw(_amount)` | Withdraw specific amount (owner only) |
| `withdrawnAll()` | Withdraw all funds (owner only) |
| `getContractBalance()` | Get current balance of the contract |

