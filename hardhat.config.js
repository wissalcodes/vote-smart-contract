require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */

const API_URL = process.env.API_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.24",
  defaultNetwork: "volta",
  networks: {
    hardhat: {},
    ganache: {
      url: "http://localhost:7545", // Ganache's RPC server URL
      chainId: 5777, // Chain ID of your local network
      accounts: {
        mnemonic:
          "0x4c15a5375fe20580125cb419402b6486b0a16a0404dffd5cee69079700d54071", // Replace with your Ganache mnemonic
      },
    },
    volta: {
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`],
      gas: 1,
      gasPrice: 10,
    },
  },
};
