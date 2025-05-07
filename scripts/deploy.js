const hre = require("hardhat");

async function main() {
  // Get the deployer's wallet/account
  const [deployer] = await hre.ethers.getSigners();
  
  console.log("Deploying the contract using the account:", deployer.address);

  // Compile and get the contract factory for URC20
  const Token = await hre.ethers.getContractFactory("URC20");

  // Deploy the contract (add constructor arguments if needed)
  const token = await Token.deploy();

  console.log("Token contract deployed at address:", token.address);
}

// Run the deployment script and handle errors
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Deployment failed:", error);
    process.exit(1);
  });