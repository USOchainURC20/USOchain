require("dotenv").config(); // Load environment variables from .env file
const hre = require("hardhat"); // Hardhat Runtime Environment

async function main() {
  try {
    const [deployer] = await hre.ethers.getSigners(); // Get the deployer account

    console.log("Deploying contracts with the account:", deployer.address);

    const balance = await deployer.getBalance(); // Get balance of the deployer

    console.log("Account balance:", hre.ethers.utils.formatEther(balance)); // Format balance to Ether

    // Get the contract factory for your URC20 token contract
    const USOD = await hre.ethers.getContractFactory("URC20");

    // Define the total supply (make sure the value is correct)
    const totalSupply = hre.ethers.BigNumber.from("571000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");

    // Deploy the contract
    const usod = await USOD.deploy(
      "Universal Stablecoin Original Dollar",  // Token name
      "USOD",                                 // Token symbol
      6,                                      // Decimals
      totalSupply                             // Total supply
    );

    await usod.deployed(); // Wait for the contract to be deployed

    console.log("✅ USOD deployed to:", usod.address); // Log the contract address

  } catch (error) {
    console.error("❌ Error deploying:", error); // Log any errors
    process.exitCode = 1; // Exit with failure status
  }
}

main(); // Run the main function