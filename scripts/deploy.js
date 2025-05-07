require("dotenv").config(); // Load environment variables from .env file
const hre = require("hardhat"); // Hardhat Runtime Environment

async function main() {
  // Get the deployer's wallet
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  // Get and display deployer's balance
  const balance = await deployer.getBalance();
  console.log("Account balance:", hre.ethers.utils.formatEther(balance));

  // Get the contract factory for URC20
  const USOD = await hre.ethers.getContractFactory("URC20");

  // Define total supply (571 octodecillion with 6 decimals)
  const totalSupply = hre.ethers.BigNumber.from("571000000000000000000000000000000000000000000000000000000000");

  // Deploy the contract
  const usod = await USOD.deploy(
    "Universal Stablecoin Original Dollar", // Token name
    "USOD",                                 // Token symbol
    6,                                      // Decimals
    totalSupply                             // Initial supply
  );

  // Wait for the contract to be deployed
  await usod.deployed();

  console.log("✅ USOD deployed to:", usod.address);
}

// Catch and print any errors during deployment
main().catch((error) => {
  console.error("❌ Error deploying:", error);
  process.exitCode = 1;
});