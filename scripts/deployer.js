const { ethers } = require("ethers");

async function main() {
  const provider = new ethers.providers.JsonRpcProvider(
    "http://localhost:8545"
  ); // Connect to Ganache's RPC server
  const signer = provider.getSigner(); // Get a signer from the provider

  const Voting = await ethers.getContractFactory("Voting");
  const Voting_ = await Voting.connect(signer).deploy(
    ["Pookie", "Mimiw", "Tino", "Simba"],
    90
  );

  console.log("Contract address:", Voting_.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
