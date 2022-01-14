const hre = require("hardhat");

async function main() {
  const Micropay = await hre.ethers.getContractFactory("MicropaymentChannel");
  const recipient = "recipient_address";
  const seconds = *seconds
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
