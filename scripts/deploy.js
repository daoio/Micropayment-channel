const hre = require("hardhat");

async function main() {
  const Micropay = await hre.ethers.getContractFactory("MicropaymentChannel");
  const recipient = "0x15314C9e4284D228a93Ead5C4d0d97cF0F67030F";
  const seconds = 800
  const micropay = await Micropay.deploy(recipient, seconds);

  await micropay.deployed();

  console.log("Micropay deployed to:", micropay.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
