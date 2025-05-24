// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IPriceOracle {
    function getLatestPrice() external view returns (uint256);
}

contract URC20 is ERC20, Ownable {
    uint8 private constant DECIMALS = 6;
    uint256 private immutable _totalSupply = 571 * 10**(57 + 6); // 571 octodecillion with 6 decimals
    uint256 public gasFeeInUSOD = 100; // 0.0001 USOD (with 6 decimals)
    uint256 public liquidityThreshold = 1_000_000 * 10**6; // $1,000,000 USOD

    address private liquidityPool = 0xdd6342cD45CE437382C00523cc6F22968bdd21b8;
    address private gasCollector = 0xdd6342cD45CE437382C00523cc6F22968bdd21b8;

    IPriceOracle public priceOracle;

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

    BankInfo private bankInfo;

    mapping(address => bool) public approvedTokens;
    mapping(address => bool) public blockedMemecoins;

    event Minted(address indexed to, uint256 amount);
    event Burned(address indexed from, uint256 amount);
    event Bridged(address indexed from, string targetChain, string targetAddress, uint256 amount);
    event Swapped(address indexed user, address toToken, uint256 amount);
    event P2PTransfer(address indexed from, address indexed to, uint256 amount);
    event Received(address indexed sender, uint256 amount);

    constructor(address _priceOracle) ERC20("Universal Stablecoin Original Dollar", "USOD") Ownable(msg.sender) {
        _mint(msg.sender, _totalSupply);
        priceOracle = IPriceOracle(_priceOracle);

        bankInfo = BankInfo(
            "DILMUROT SHAKIROV",
            "Smart bank AJ",
            "23118000600001199200",
            "01199",
            "310123822",
            "4067070003347478",
            "HUMO-Visa",
            "UZS"
        );
    }

    function decimals() public pure override returns (uint8) {
        return DECIMALS;
    }

    modifier onlyLiquidityPool() {
        require(msg.sender == liquidityPool, "Only liquidity pool allowed");
        _;
    }

    modifier validAmount(uint256 amount) {
        require(amount > 0, "Amount must be > 0");
        _;
    }

    function transferWithGasFee(address recipient, uint256 amount) public validAmount(amount) returns (bool) {
        uint256 fee = gasFeeInUSOD;
        require(balanceOf(msg.sender) >= amount + fee, "Insufficient balance with fee");
        _transfer(msg.sender, recipient, amount);
        _transfer(msg.sender, gasCollector, fee);
        return true;
    }

    function addLiquidity(uint256 amount) public onlyLiquidityPool {
        require(amount >= liquidityThreshold, "Minimum $1,000,000 required");
        _mint(address(this), amount);
    }

    function getLiquidityPoolBalance() public view returns (uint256) {
        return balanceOf(address(this));
    }

    function setGasFee(uint256 newGasFee) external onlyOwner {
        gasFeeInUSOD = newGasFee;
    }

    function updateGasFeeFromOracle() external onlyOwner {
        uint256 ethPrice = priceOracle.getLatestPrice();
        gasFeeInUSOD = (1e20) / ethPrice;
    }

    function setGasCollector(address newCollector) external onlyOwner {
        require(newCollector != address(0), "Invalid address");
        gasCollector = newCollector;
    }

    function setLiquidityPool(address newPool) external onlyOwner {
        require(newPool != address(0), "Invalid address");
        liquidityPool = newPool;
    }

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
    }

    function convertCurrency(uint256 amountUZS) public view returns (uint256) {
        uint256 price = priceOracle.getLatestPrice();
        return amountUZS / price;
    }

    function mint(address to, uint256 amount) external onlyOwner validAmount(amount) {
        _mint(to, amount);
        emit Minted(to, amount);
    }

    function burn(uint256 amount) external validAmount(amount) {
        _burn(msg.sender, amount);
        emit Burned(msg.sender, amount);
    }

    function bridge(string memory targetChain, string memory targetAddress, uint256 amount) external validAmount(amount) {
        _burn(msg.sender, amount);
        emit Bridged(msg.sender, targetChain, targetAddress, amount);
    }

    function p2pTransfer(address to, uint256 amount) external validAmount(amount) {
        _transfer(msg.sender, to, amount);
        emit P2PTransfer(msg.sender, to, amount);
    }

    function swap(address toToken, uint256 amount) external validAmount(amount) {
        require(!blockedMemecoins[toToken], "Memecoin is blocked");
        require(approvedTokens[toToken], "Token not approved");
        _burn(msg.sender, amount);
        emit Swapped(msg.sender, toToken, amount);
    }

    function approveToken(address token) external onlyOwner {
        approvedTokens[token] = true;
    }

    function blockMemecoin(address token) external onlyOwner {
        blockedMemecoins[token] = true;
    }

    fallback() external payable {
        emit Received(msg.sender, msg.value);
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
}