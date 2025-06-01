const hre = require("hardhat");
const { ethers } = hre;

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const dummyPriceOracle = deployer.address;

  const URC20 = await ethers.getContractFactory("URC20");
  const urc20 = await URC20.deploy(dummyPriceOracle);

  await urc20.deployed();

  console.log("URC20 deployed to:", urc20.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });