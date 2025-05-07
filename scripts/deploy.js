async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
  
    const USOD = await ethers.getContractFactory("URC20");
    const priceOracleAddress = "0x0000000000000000000000000000000000000000"; // dummy oracle address
    const usod = await USOD.deploy(priceOracleAddress);
  
    await usod.deployed();
    console.log("USOD deployed to:", usod.address);
  }
  
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });