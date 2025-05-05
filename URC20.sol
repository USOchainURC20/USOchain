// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// URC20 Token contract (USD-Pegged)
contract URC20 is ERC20, Ownable {
    uint256 private _totalSupply = 571000000000000000000000000; // 571 billion total supply
    uint256 public gasFeeInUSO = 100000000000000; // 0.0001 USO in wei (based on USO token decimals)

    constructor() ERC20("URC20 Token", "URC20") {
        _mint(msg.sender, _totalSupply);
    }

    // Function to transfer tokens with gas fee adjustment (using the USO gas fee)
    function transferWithGasFee(address recipient, uint256 amount) public returns (bool) {
        uint256 fee = gasFeeInUSO;
        uint256 amountAfterFee = amount - fee;

        // Transfer the amount after deducting the gas fee
        _transfer(_msgSender(), recipient, amountAfterFee);
        
        // Logic for the fee collection (Could be sent to a specific address)
        // _transfer(_msgSender(), gasFeeReceiverAddress, fee);

        return true;
    }

    // Allow the owner to change the gas fee
    function setGasFee(uint256 newGasFee) external onlyOwner {
        gasFeeInUSO = newGasFee;
    }
}