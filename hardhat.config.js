require("dotenv").config(); // Load environment variables from the .env file
require("@nomicfoundation/hardhat-toolbox"); // Hardhat toolbox which includes useful plugins

module.exports = {
  solidity: "0.8.20",  // Specifies the version of Solidity to be used in the project
  networks: {
    usochain: {
      url: "http://127.0.0.1:8545",  // RPC URL of the USOchain network (localhost in this case)
      chainId: 571,  // Chain ID for the USOchain network
      accounts: [`0x${process.env.PRIVATE_KEY}`],  // Private key fetched from the .env file for deploying contracts
    },
  },
};