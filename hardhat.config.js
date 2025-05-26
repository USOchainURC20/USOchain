require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.20",
      },
    ],
  },
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
      chainId: 31337, // default chainId for localhost network
      accounts: [process.env.PRIVATE_KEY].filter(Boolean),
    },
    usochain: {
      url: "http://usochain.urc:8545",
      chainId: 1991,
      accounts: [process.env.PRIVATE_KEY].filter(Boolean),
    },
  },
};
