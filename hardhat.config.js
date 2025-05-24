require("dotenv").config();

module.exports = {
  defaultNetwork: "usochain",
  networks: {
    usochain: {
      url: "https://rpc.metachain.io",
      chainId: 571,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  solidity: "0.8.20",
};
