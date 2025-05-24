require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    usochain: {
      url: process.env.RPC_URL,
      accounts: [process.env.PRIVATE_KEY].filter(Boolean),
      chainId: 571,
    },
  },
};
