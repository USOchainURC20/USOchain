require("dotenv").config(); // Load environment variables from the .env file
require("@nomicfoundation/hardhat-toolbox"); // Hardhat toolbox which includes useful plugins

module.exports = {
  solidity: "0.8.20",
  networks: {
    usochain: {
      url: "http://127.0.0.1:8545", // RPC URL
      chainId: 571, // Chain ID
      accounts: [`0x${process.env.PRIVATE_KEY}`], // Private key from .env
    },
  },
};