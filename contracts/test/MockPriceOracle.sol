// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockPriceOracle {
    function getLatestPrice() external pure returns (uint256) {
        return 2000 * 1e6; // example price: 2000.000000 (6 decimals)
    }
}