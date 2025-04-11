const hre = require("hardhat");
const { ethers } = require("ethers"); // ✅ Import từ ethers package

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  const vendorAddress = "0x4A679253410272dd5232B3Ff7cF5dbB88f295319";
  const tokenAddress = "0xa85233C63b9Ee964Add6F2cffe00Fd84eb32338f";

  const amountInEth = "10.0";
  const amountOfTokens = "10000";

  console.log(`Funding Vendor contract at ${vendorAddress} with ${amountInEth} ETH...`);

  // ✅ Fund ETH
  const txEth = await deployer.sendTransaction({
    to: vendorAddress,
    value: ethers.parseEther(amountInEth),
  });
  await txEth.wait();
  console.log(`✅ ETH Transaction complete! Hash: ${txEth.hash}`);

  // ✅ Fund Token
  const Token = await hre.ethers.getContractFactory("YourToken");
  const token = await Token.attach(tokenAddress);

  console.log(`Funding Vendor contract at ${vendorAddress} with ${amountOfTokens} tokens...`);

  const txToken = await token.transfer(vendorAddress, ethers.parseUnits(amountOfTokens, 18));
  await txToken.wait();
  console.log(`✅ Token Transaction complete! Hash: ${txToken.hash}`);

  // ✅ Check balances
  const balanceEth = await hre.ethers.provider.getBalance(vendorAddress);
  const balanceToken = await token.balanceOf(vendorAddress);

  console.log(`Vendor contract balances:`);
  console.log(`- ETH: ${ethers.formatEther(balanceEth)} ETH`);
  console.log(`- Token: ${ethers.formatUnits(balanceToken, 18)} TOKEN`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
