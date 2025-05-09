require("dotenv").config(); // Load environment variables from .env file
const hre = require("hardhat"); // Hardhat Runtime Environment

async function main() {
  try {
    const [deployer] = await hre.ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const balance = await deployer.getBalance();
    console.log("Account balance:", hre.ethers.utils.formatEther(balance));

    const USOD = await hre.ethers.getContractFactory("URC20");

    const totalSupply = hre.ethers.BigNumber.from("571000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");

    const usod = await USOD.deploy(
      "Universal Stablecoin Original Dollar",
      "USOD",                                 
      6,                                      
      totalSupply                             
    );

    await usod.deployed();

    console.log("✅ USOD deployed to:", usod.address);

  } catch (error) {
    console.error("❌ Error deploying:", error);
    process.exitCode = 1;
  }
}

main();