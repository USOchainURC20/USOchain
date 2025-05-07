require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.20",  // Adjust Solidity version as needed
  networks: {
    mainnet: {
      url: "https://usochain.urc",  // Your RPC URL
      chainId: 571,  // Your Chain ID (replace with the actual one if different)
      accounts: [`0x${process.env.PRIVATE_KEY}`],  // Your private key from .env file
    },
  },
};