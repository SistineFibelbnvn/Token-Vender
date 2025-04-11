const hre = require("hardhat");

async function main() {
  const Token = await hre.ethers.getContractFactory("YourToken");
  const token = await Token.deploy();
  await token.waitForDeployment(); // 🔥 sửa dòng này

  console.log(`Token deployed to: ${token.target}`); // 🔥 Ethers v6: dùng target thay cho address

  const Vendor = await hre.ethers.getContractFactory("Vendor");
  const vendor = await Vendor.deploy(token.target); // 🔥 truyền target thay vì address
  await vendor.waitForDeployment(); // 🔥 sửa dòng này

  console.log(`Vendor deployed to: ${vendor.target}`); // 🔥 dùng target
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
