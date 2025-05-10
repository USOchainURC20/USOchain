require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.20",
  networks: {
    usochain: {
      url: process.env.USOCHAIN_RPC_URL,
      chainId: 571,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
  },
};