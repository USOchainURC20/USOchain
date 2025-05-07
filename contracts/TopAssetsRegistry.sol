// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TopAssetsRegistry is Ownable {
    string[] public top100Tokens;
    string[] public topCEXs;
    string[] public topDEXs;

    constructor() Ownable(msg.sender) {
        // You can initialize default values here if desired
    }

    event TokenListed(string token);
    event CEXListed(string cex);
    event DEXListed(string dex);

    constructor() {}

    // Add Top Tokens
    function addTopTokenAuto(string memory token) external onlyOwner {
        top100Tokens.push(token);
        emit TokenListed(token);
    }

    // Add CEX (Centralized Exchange)
    function addCEXAuto(string memory cex) external onlyOwner {
        topCEXs.push(cex);
        emit CEXListed(cex);
    }

    // Add DEX (Decentralized Exchange)
    function addDEXAuto(string memory dex) external onlyOwner {
        topDEXs.push(dex);
        emit DEXListed(dex);
    }

    // Initialize Default Listings for Top Tokens
    function initializeTop100Tokens() external onlyOwner {
        string[100] memory tokens = [
            "BTC", "ETH", "BNB", "USDT", "SOL", "XRP", "DOGE", "TON", "ADA", "AVAX",
            "SHIB", "DOT", "TRX", "LINK", "WBTC", "MATIC", "UNI", "LTC", "ICP", "DAI",
            "BCH", "APT", "ETC", "STX", "IMX", "OKB", "FIL", "ARB", "HBAR", "NEAR",
            "CRO", "LDO", "TAO", "INJ", "MKR", "RETH", "RUNE", "FDUSD", "TUSD", "GRT",
            "USDD", "OP", "SUI", "SNX", "FRAX", "PEPE", "MANTA", "EGLD", "BGB", "XLM",
            "KAS", "THETA", "AR", "AXS", "PAXG", "WOO", "ORDI", "JASMY", "QNT", "XTZ",
            "EOS", "AAVE", "CHZ", "BSV", "SAND", "FLOW", "XEC", "USDP", "MINA", "GALA",
            "KAVA", "TWT", "CRV", "PENDLE", "ZEC", "ENS", "GT", "IOTA", "DYDX", "XAUT",
            "FTM", "CSPR", "ANKR", "SXP", "NXRA", "FLR", "1INCH", "YFI", "LUNA", "CELR",
            "AGIX", "UMA", "RVN", "ZIL", "BAT", "BICO", "SKL", "ENJ", "NMR", "CKB"
        ];

        for (uint256 i = 0; i < tokens.length; i++) {
            top100Tokens.push(tokens[i]);
            emit TokenListed(tokens[i]);
        }
    }

    // Initialize Default Listings for Top CEXs
    function initializeTop50CEXs() external onlyOwner {
        string[50] memory cexs = [
            "Binance", "Coinbase", "Bybit", "OKX", "KuCoin", "Gate.io", "MEXC", "Kraken", "Bitfinex", "Bitget",
            "Huobi", "Poloniex", "Upbit", "Crypto.com", "Bithumb", "BingX", "Phemex", "ProBit", "WhiteBIT", "CoinEx",
            "AscendEX", "LBank", "XT.com", "DigiFinex", "Indodax", "WazirX", "BitMart", "LATOKEN", "ZB.com", "Coincheck",
            "Coinone", "Bitbns", "BTC Markets", "NovaDAX", "Korbit", "AAX", "Bit2C", "BitFlyer", "CEX.io", "Exmo",
            "Paybito", "Bitso", "Foxbit", "Coinsbit", "Tidex", "Zaif", "Quidax", "Bitbank", "Rain", "BitoPro"
        ];

        for (uint256 i = 0; i < cexs.length; i++) {
            topCEXs.push(cexs[i]);
            emit CEXListed(cexs[i]);
        }
    }

    // Initialize Default Listings for Top DEXs
    function initializeTop50DEXs() external onlyOwner {
        string[50] memory dexs = [
            "Uniswap", "PancakeSwap", "Curve", "SushiSwap", "Balancer", "1inch", "DODO", "KyberSwap", "Raydium", "Jupiter",
            "Orca", "THORSwap", "Saber", "QuickSwap", "Trader Joe", "SpookySwap", "Beethoven X", "Solidly", "Velodrome", "Wombat",
            "ApeSwap", "Shibaswap", "Maverick", "Firebird", "WOOFi", "Camelot", "Biswap", "Klex", "BabySwap", "LFGSwap",
            "OpenOcean", "MeshSwap", "Zyberswap", "MojitoSwap", "MM Finance", "BakerySwap", "BurgerSwap", "DeFiChain DEX", "Nomiswap", "Tethys Finance",
            "Minswap", "Tinyman", "Ubeswap", "Wanswap", "ViperSwap", "NetSwap", "VVS Finance", "YuzuSwap", "Honeyswap", "SundaeSwap"
        ];

        for (uint256 i = 0; i < dexs.length; i++) {
            topDEXs.push(dexs[i]);
            emit DEXListed(dexs[i]);
        }
    }

    // Get Top Tokens
    function getTop100Tokens() external view returns (string[] memory) {
        return top100Tokens;
    }

    // Get Top CEXs
    function getTopCEXs() external view returns (string[] memory) {
        return topCEXs;
    }

    // Get Top DEXs
    function getTopDEXs() external view returns (string[] memory) {
        return topDEXs;
    }
}