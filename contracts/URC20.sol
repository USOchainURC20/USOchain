// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IPriceOracle {
    function getLatestPrice() external view returns (uint256);
}

contract URC20 is ERC20, Ownable {
    uint256 private immutable _totalSupply = 571e75; // 571 Octodecillion
    uint256 public gasFeeInUSOD = 100000000000000; // 0.0001 * 10^18
    uint256 public liquidityThreshold = 1_000_000 * 10**18; // $1,000,000 USOD equivalent

    // BankInfo and address (liquidityPool, gasCollector) are made private for owner only
    address private liquidityPool = 0xdd6342cD45CE437382C00523cc6F22968bdd21b8;
    address private gasCollector = 0xdd6342cD45CE437382C00523cc6F22968bdd21b8;

    IPriceOracle public priceOracle;  // Corrected visibility (public)

    struct BankInfo {
        string fullName;
        string bankName;
        string accountNumber;
        string mfo;
        string inn;
        string cardNumber;
        string cardType;
        string accountCurrency;
    }

    // BankInfo is private and only accessible by the owner
    BankInfo private bankInfo = BankInfo(
        "DILMUROT SHAKIROV",
        "Smart bank AJ",
        "23118000600001199200",
        "01199",
        "310123822",
        "4067070003347478",
        "HUMO-Visa",
        "UZS"
    );

    mapping(address => bool) public approvedTokens;
    mapping(address => bool) public blockedMemecoins;

    event BankDetailsUpdated();
    event Minted(address indexed to, uint256 amount);
    event Burned(address indexed from, uint256 amount);
    event Bridged(address indexed from, string targetChain, string targetAddress, uint256 amount);
    event Swapped(address indexed user, address toToken, uint256 amount);
    event P2PTransfer(address indexed from, address indexed to, uint256 amount);
    event Received(address indexed sender, uint256 amount);

    constructor(address _priceOracle) ERC20("Universal Stablecoin Original Dollar", "USOD") {
        _mint(msg.sender, _totalSupply);
        priceOracle = IPriceOracle(_priceOracle);
    }

    modifier onlyLiquidityPool() {
        require(msg.sender == liquidityPool, "Only liquidity pool can call this function");
        _;
    }

    modifier validAmount(uint256 amount) {
        require(amount > 0, "Amount must be greater than 0");
        _;
    }

    // Function to transfer with gas fee
    function transferWithGasFee(address recipient, uint256 amount) public validAmount(amount) returns (bool) {
        uint256 fee = gasFeeInUSOD;
        require(balanceOf(msg.sender) >= amount + fee, "Insufficient balance including gas fee");
        _transfer(msg.sender, recipient, amount);
        _transfer(msg.sender, gasCollector, fee);
        return true;
    }

    // Function to add liquidity
    function addLiquidity(uint256 amount) public onlyLiquidityPool {
        require(amount >= liquidityThreshold, "Minimum liquidity is $1,000,000");
        _mint(address(this), amount);
    }

    // Get liquidity pool balance
    function getLiquidityPoolBalance() public view returns (uint256) {
        return balanceOf(address(this));
    }

    // Set gas fee
    function setGasFee(uint256 newGasFee) external onlyOwner {
        gasFeeInUSOD = newGasFee;
    }

    // Update gas fee from oracle
    function updateGasFeeFromOracle() external onlyOwner {
        uint256 ethPrice = priceOracle.getLatestPrice();
        gasFeeInUSOD = (1e14 * 1e18) / ethPrice; // 0.0001 in USOD equivalent
    }

    // Set gas collector address
    function setGasCollector(address newCollector) external onlyOwner {
        require(newCollector != address(0), "Invalid address");
        gasCollector = newCollector;
    }

    // Function to allow owner to change liquidity pool address
    function setLiquidityPool(address newPool) external onlyOwner {
        require(newPool != address(0), "Invalid address");
        liquidityPool = newPool;
    }

    // Update bank details, only accessible by owner
    function updateBankDetails(
        string memory _fullName,
        string memory _bankName,
        string memory _accountNumber,
        string memory _mfo,
        string memory _inn,
        string memory _cardNumber,
        string memory _cardType,
        string memory _accountCurrency
    ) public onlyOwner {
        bankInfo = BankInfo(_fullName, _bankName, _accountNumber, _mfo, _inn, _cardNumber, _cardType, _accountCurrency);
        emit BankDetailsUpdated(); // No sensitive data emitted
    }

    // Function to convert UZS to USOD using the price oracle
    function convertCurrency(uint256 amountUZS) public view returns (uint256) {
        uint256 price = priceOracle.getLatestPrice();
        return amountUZS / price;
    }

    // Mint new tokens
    function mint(address to, uint256 amount) external onlyOwner validAmount(amount) {
        _mint(to, amount);
        emit Minted(to, amount);
    }

    // Burn tokens
    function burn(uint256 amount) external validAmount(amount) {
        _burn(msg.sender, amount);
        emit Burned(msg.sender, amount);
    }

    // Bridge tokens to another chain
    function bridge(string memory targetChain, string memory targetAddress, uint256 amount) external validAmount(amount) {
        _burn(msg.sender, amount);
        emit Bridged(msg.sender, targetChain, targetAddress, amount);
    }

    // P2P transfer function
    function p2pTransfer(address to, uint256 amount) external validAmount(amount) {
        _transfer(msg.sender, to, amount);
        emit P2PTransfer(msg.sender, to, amount);
    }

    // Swap tokens for other approved tokens
    function swap(address toToken, uint256 amount) external validAmount(amount) {
        require(!blockedMemecoins[toToken], "Memecoin is blocked");
        require(approvedTokens[toToken], "Only approved tokens allowed");
        _burn(msg.sender, amount);
        emit Swapped(msg.sender, toToken, amount);
    }

    // Approve a token for swapping
    function approveToken(address token) external onlyOwner {
        approvedTokens[token] = true;
    }

    // Block memecoins
    function blockMemecoin(address token) external onlyOwner {
        blockedMemecoins[token] = true;
    }

    // Fallback function to accept ETH
    fallback() external payable {
        emit Received(msg.sender, msg.value);
    }

    // Receive function to accept ETH
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
}