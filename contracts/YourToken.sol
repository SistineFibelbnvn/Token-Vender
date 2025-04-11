// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YourToken is ERC20 {
    constructor() ERC20("YourToken", "YTK") {
        _mint(msg.sender, 100000 * 10 ** 18); // Mint 1000 tokens to deployer
    }
}
