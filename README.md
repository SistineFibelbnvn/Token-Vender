Lần lượt chạy các lệnh:

npm install

npx hardhat run scripts/deploy.js --network localhost

Kết quả: 

Token deployed to: 0xa85233C63b9Ee964Add6F2cffe00Fd84eb32338f
Vendor deployed to: 0x4A679253410272dd5232B3Ff7cF5dbB88f295319

Sửa lại địa chỉ ở app.js và fund-vendor.js

npx hardhat run scripts/fund-vendor.js --network localhost

npx serve




