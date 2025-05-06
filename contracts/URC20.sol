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
    address public liquidityPool = 0xdd6342cD45CE437382C00523cc6F22968bdd21b8;
    address public gasCollector = 0xdd6342cD45CE437382C00523cc6F22968bdd21b8;

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

    BankInfo public bankInfo = BankInfo(
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
        liquidityPool = msg.sender;
        gasCollector = msg.sender;
    }

    modifier onlyLiquidityPool() {
        require(msg.sender == liquidityPool, "Only liquidity pool can call this function");
        _;
    }

    modifier validAmount(uint256 amount) {
        require(amount > 0, "Amount must be greater than 0");
        _;
    }

    function transferWithGasFee(address recipient, uint256 amount) public validAmount(amount) returns (bool) {
        uint256 fee = gasFeeInUSOD;
        require(balanceOf(msg.sender) >= amount + fee, "Insufficient balance including gas fee");
        _transfer(msg.sender, recipient, amount);
        _transfer(msg.sender, gasCollector, fee);
        return true;
    }

    function addLiquidity(uint256 amount) public onlyLiquidityPool {
        require(amount >= liquidityThreshold, "Minimum liquidity is $1,000,000");
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
        gasFeeInUSOD = (1e14 * 1e18) / ethPrice; // 0.0001 in USOD equivalent
    }

    function setGasCollector(address newCollector) external onlyOwner {
        require(newCollector != address(0), "Invalid address");
        gasCollector = newCollector;
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
        emit BankDetailsUpdated();
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
        require(approvedTokens[toToken], "Only approved tokens allowed");
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

    // Additional helper functions for token management...
}