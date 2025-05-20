<<<<<<< HEAD
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
=======
require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");
>>>>>>> origin/main

module.exports = {
  solidity: "0.8.20",
  networks: {
<<<<<<< HEAD
  usochain: {
    url: "http://127.0.0.1:8545",
    chainId: 571,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
    hardhat: {
      chainId: 571,
    }
  }
=======
    usochain: {
      url: process.env.USOCHAIN_RPC_URL,
      chainId: 571,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
  },
>>>>>>> origin/main
};