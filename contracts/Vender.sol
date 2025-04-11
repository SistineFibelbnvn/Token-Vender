// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Vendor is Ownable {
    IERC20 public yourToken;
    uint256 public constant tokensPerEth = 100;

    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
    event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);
    event Withdraw(address owner, uint256 amount);

    constructor(address tokenAddress) Ownable(msg.sender){
        yourToken = IERC20(tokenAddress);
    }
    // Allow contract to receive ETH
    receive() external payable {}
    // Buy tokens with ETH
    function buyTokens() public payable {
        require(msg.value > 0, "Send ETH to buy tokens");

        uint256 amountToBuy = msg.value * tokensPerEth;
        uint256 vendorBalance = yourToken.balanceOf(address(this));
        require(vendorBalance >= amountToBuy, "Vendor doesn't have enough tokens");

        yourToken.transfer(msg.sender, amountToBuy);
        emit BuyTokens(msg.sender, msg.value, amountToBuy);
    }

    // Sell tokens for ETH
    function sellTokens(uint256 tokenAmount) public {
        require(tokenAmount > 0, "Specify token amount to sell");

        uint256 allowance = yourToken.allowance(msg.sender, address(this));
        require(allowance >= tokenAmount, "Check token allowance");

        uint256 ethAmount = tokenAmount / tokensPerEth;
        uint256 contractEthBalance = address(this).balance;
        require(contractEthBalance >= ethAmount, "Vendor doesn't have enough ETH");

        yourToken.transferFrom(msg.sender, address(this), tokenAmount);
        payable(msg.sender).transfer(ethAmount);

        emit SellTokens(msg.sender, tokenAmount, ethAmount);
    }

    // Owner withdraw ETH
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Nothing to withdraw");

        payable(msg.sender).transfer(balance);
        emit Withdraw(msg.sender, balance);
    }
}
