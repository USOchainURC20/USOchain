// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TopAssetsRegistry is Ownable {
    string[] public top100Tokens;
    string[] public topCEXs;
    string[] public topDEXs;

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
        addTopTokenAuto("BTC");
        addTopTokenAuto("ETH");
        addTopTokenAuto("BNB");
        addTopTokenAuto("USDT");
        addTopTokenAuto("SOL");
        addTopTokenAuto("XRP");
        addTopTokenAuto("DOGE");
        addTopTokenAuto("TON");
        addTopTokenAuto("ADA");
        addTopTokenAuto("AVAX");
        addTopTokenAuto("SHIB");
        addTopTokenAuto("DOT");
        addTopTokenAuto("TRX");
        addTopTokenAuto("LINK");
        addTopTokenAuto("WBTC");
        addTopTokenAuto("MATIC");
        addTopTokenAuto("UNI");
        addTopTokenAuto("LTC");
        addTopTokenAuto("ICP");
        addTopTokenAuto("DAI");
        addTopTokenAuto("BCH");
        addTopTokenAuto("APT");
        addTopTokenAuto("ETC");
        addTopTokenAuto("STX");
        addTopTokenAuto("IMX");
        addTopTokenAuto("OKB");
        addTopTokenAuto("FIL");
        addTopTokenAuto("ARB");
        addTopTokenAuto("HBAR");
        addTopTokenAuto("NEAR");
        addTopTokenAuto("CRO");
        addTopTokenAuto("LDO");
        addTopTokenAuto("TAO");
        addTopTokenAuto("INJ");
        addTopTokenAuto("MKR");
        addTopTokenAuto("RETH");
        addTopTokenAuto("RUNE");
        addTopTokenAuto("FDUSD");
        addTopTokenAuto("TUSD");
        addTopTokenAuto("GRT");
        addTopTokenAuto("USDD");
        addTopTokenAuto("OP");
        addTopTokenAuto("SUI");
        addTopTokenAuto("SNX");
        addTopTokenAuto("FRAX");
        addTopTokenAuto("PEPE");
        addTopTokenAuto("MANTA");
        addTopTokenAuto("EGLD");
        addTopTokenAuto("BGB");
        addTopTokenAuto("XLM");
        addTopTokenAuto("KAS");
        addTopTokenAuto("THETA");
        addTopTokenAuto("AR");
        addTopTokenAuto("AXS");
        addTopTokenAuto("PAXG");
        addTopTokenAuto("WOO");
        addTopTokenAuto("ORDI");
        addTopTokenAuto("JASMY");
        addTopTokenAuto("QNT");
        addTopTokenAuto("XTZ");
        addTopTokenAuto("EOS");
        addTopTokenAuto("AAVE");
        addTopTokenAuto("CHZ");
        addTopTokenAuto("BSV");
        addTopTokenAuto("SAND");
        addTopTokenAuto("FLOW");
        addTopTokenAuto("XEC");
        addTopTokenAuto("USDP");
        addTopTokenAuto("MINA");
        addTopTokenAuto("GALA");
        addTopTokenAuto("KAVA");
        addTopTokenAuto("TWT");
        addTopTokenAuto("CRV");
        addTopTokenAuto("PENDLE");
        addTopTokenAuto("ZEC");
        addTopTokenAuto("ENS");
        addTopTokenAuto("GT");
        addTopTokenAuto("IOTA");
        addTopTokenAuto("DYDX");
        addTopTokenAuto("XAUT");
        addTopTokenAuto("FTM");
        addTopTokenAuto("CSPR");
        addTopTokenAuto("ANKR");
        addTopTokenAuto("SXP");
        addTopTokenAuto("NXRA");
        addTopTokenAuto("FLR");
        addTopTokenAuto("1INCH");
        addTopTokenAuto("YFI");
        addTopTokenAuto("LUNA");
        addTopTokenAuto("CELR");
        addTopTokenAuto("AGIX");
        addTopTokenAuto("UMA");
        addTopTokenAuto("RVN");
        addTopTokenAuto("ZIL");
        addTopTokenAuto("BAT");
        addTopTokenAuto("BICO");
        addTopTokenAuto("SKL");
        addTopTokenAuto("ENJ");
        addTopTokenAuto("NMR");
        addTopTokenAuto("CKB");
    }

    // Initialize Default Listings for Top CEXs
    function initializeTop50CEXs() external onlyOwner {
        addCEXAuto("Binance");
        addCEXAuto("Coinbase");
        addCEXAuto("Bybit");
        addCEXAuto("OKX");
        addCEXAuto("KuCoin");
        addCEXAuto("Gate.io");
        addCEXAuto("MEXC");
        addCEXAuto("Kraken");
        addCEXAuto("Bitfinex");
        addCEXAuto("Bitget");
        addCEXAuto("Huobi");
        addCEXAuto("Poloniex");
        addCEXAuto("Upbit");
        addCEXAuto("Crypto.com");
        addCEXAuto("Bithumb");
        addCEXAuto("BingX");
        addCEXAuto("Phemex");
        addCEXAuto("ProBit");
        addCEXAuto("WhiteBIT");
        addCEXAuto("CoinEx");
        addCEXAuto("AscendEX");
        addCEXAuto("LBank");
        addCEXAuto("XT.com");
        addCEXAuto("DigiFinex");
        addCEXAuto("Indodax");
        addCEXAuto("WazirX");
        addCEXAuto("BitMart");
        addCEXAuto("LATOKEN");
        addCEXAuto("ZB.com");
        addCEXAuto("Coincheck");
        addCEXAuto("Coinone");
        addCEXAuto("Bitbns");
        addCEXAuto("BTC Markets");
        addCEXAuto("NovaDAX");
        addCEXAuto("Korbit");
        addCEXAuto("AAX");
        addCEXAuto("Bit2C");
        addCEXAuto("BitFlyer");
        addCEXAuto("CEX.io");
        addCEXAuto("Exmo");
        addCEXAuto("Paybito");
        addCEXAuto("Bitso");
        addCEXAuto("Foxbit");
        addCEXAuto("Coinsbit");
        addCEXAuto("Tidex");
        addCEXAuto("Zaif");
        addCEXAuto("Quidax");
        addCEXAuto("Bitbank");
        addCEXAuto("Rain");
        addCEXAuto("BitoPro");
    }

    // Initialize Default Listings for Top DEXs
    function initializeTop50DEXs() external onlyOwner {
        addDEXAuto("Uniswap");
        addDEXAuto("PancakeSwap");
        addDEXAuto("Curve");
        addDEXAuto("SushiSwap");
        addDEXAuto("Balancer");
        addDEXAuto("1inch");
        addDEXAuto("DODO");
        addDEXAuto("KyberSwap");
        addDEXAuto("Raydium");
        addDEXAuto("Jupiter");
        addDEXAuto("Orca");
        addDEXAuto("THORSwap");
        addDEXAuto("Saber");
        addDEXAuto("QuickSwap");
        addDEXAuto("Trader Joe");
        addDEXAuto("SpookySwap");
        addDEXAuto("Beethoven X");
        addDEXAuto("Solidly");
        addDEXAuto("Velodrome");
        addDEXAuto("Wombat");
        addDEXAuto("ApeSwap");
        addDEXAuto("Shibaswap");
        addDEXAuto("Maverick");
        addDEXAuto("Firebird");
        addDEXAuto("WOOFi");
        addDEXAuto("Camelot");
        addDEXAuto("Biswap");
        addDEXAuto("Klex");
        addDEXAuto("BabySwap");
        addDEXAuto("LFGSwap");
        addDEXAuto("OpenOcean");
        addDEXAuto("MeshSwap");
        addDEXAuto("Zyberswap");
        addDEXAuto("MojitoSwap");
        addDEXAuto("MM Finance");
        addDEXAuto("BakerySwap");
        addDEXAuto("BurgerSwap");
        addDEXAuto("DeFiChain DEX");
        addDEXAuto("Nomiswap");
        addDEXAuto("Tethys Finance");
        addDEXAuto("Minswap");
        addDEXAuto("Tinyman");
        addDEXAuto("Ubeswap");
        addDEXAuto("Wanswap");
        addDEXAuto("ViperSwap");
        addDEXAuto("NetSwap");
        addDEXAuto("VVS Finance");
        addDEXAuto("YuzuSwap");
        addDEXAuto("Honeyswap");
        addDEXAuto("SundaeSwap");
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
