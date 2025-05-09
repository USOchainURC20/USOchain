require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.20",
  networks: {
    usochain: {
      url: `https://mainnet.infura.io/v3/${process.env.INFURA_API_KEY}`,  // Use the API key from the .env file
      chainId: 571,  // USOChain network ID
      accounts: [`0x${process.env.PRIVATE_KEY}`],  // Private key for deployment
    },
  },
};