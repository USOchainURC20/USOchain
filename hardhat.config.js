require("dotenv").config({ path: './config/.env' });
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.20",
  networks: {
    usochain: {
      url: "http://127.0.0.1:8545",
      chainId: 571,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
  },
};