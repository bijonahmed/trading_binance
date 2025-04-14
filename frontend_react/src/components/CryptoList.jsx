import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

// Updated crypto list with alias
const cryptos = [
  { symbol: "BTC", name: "BTC/USDT", alias: "Bitcoin", image: "/fasttrading/images/bitcoin.png" },
  { symbol: "ETH", name: "ETH/USDT", alias: "Ethereum", image: "/fasttrading/images/eth.png" },
  { symbol: "XRP", name: "XRP/USDT", alias: "XRP", image: "/fasttrading/images/xrp.png" },
  { symbol: "ADA", name: "ADA/USDT", alias: "Cardano", image: "/fasttrading/images/ada.png" },
  { symbol: "SOL", name: "SOL/USDT", alias: "Solana", image: "/fasttrading/images/sol.png" },
  { symbol: "DOT", name: "DOT/USDT", alias: "Polkadot", image: "/fasttrading/images/dot.png" },
  { symbol: "DOGE", name: "DOGE/USDT", alias: "Dogecoin", image: "/fasttrading/images/doge.png" },
  { symbol: "SHIB", name: "SHIB/USDT", alias: "Shiba Inu", image: "/fasttrading/images/shib.png" },
  { symbol: "LTC", name: "LTC/USDT", alias: "Litecoin", image: "/fasttrading/images/ltc.png" },
  { symbol: "LINK", name: "LINK/USDT", alias: "Chainlink", image: "/fasttrading/images/link.png" },
  { symbol: "AVAX", name: "AVAX/USDT", alias: "Avalanche", image: "/fasttrading/images/avax.png" },
  { symbol: "UNI", name: "UNI/USDT", alias: "Uniswap", image: "/fasttrading/images/uni.png" },
  { symbol: "XLM", name: "XLM/USDT", alias: "Stellar", image: "/fasttrading/images/xlm.png" },
  { symbol: "VET", name: "VET/USDT", alias: "VeChain", image: "/fasttrading/images/vet.png" },
  { symbol: "TRX", name: "TRX/USDT", alias: "Tron", image: "/fasttrading/images/trx.png" },
  { symbol: "BCH", name: "BCH/USDT", alias: "Bitcoin Cash", image: "/fasttrading/images/bitcoin-cash-circle.webp" },
  { symbol: "ICP", name: "ICP/USDT", alias: "Internet Computer", image: "/fasttrading/images/ICP.webp" },
  { symbol: "Bitshares(BTS)", name: "BTS/USDT", alias: "BTS", image: "/fasttrading/images/bts.png" },
  { symbol: "NEAR", name: "NEAR/USDT", alias: "NEAR Protocol", image: "/fasttrading/images/near.png" },
  { symbol: "FIL", name: "FIL/USDT", alias: "Filecoin", image: "/fasttrading/images/filecoin.webp" },
  { symbol: "ALGO", name: "ALGO/USDT", alias: "Algorand", image: "/fasttrading/images/algo.webp" },
  { symbol: "EOS", name: "EOS/USDT", alias: "EOS", image: "/fasttrading/images/eos-eos-logo.webp" },
  { symbol: "APE", name: "APE/USDT", alias: "ApeCoin", image: "/fasttrading/images/apecoin.jpg" },
];

// CoinGecko symbol mapping
const coinGeckoIdMap = {
  BTS: "bitshares",
  BCH: "bitcoin-cash",
  ICP: "internet-computer",
  NEAR: "near",
  FIL: "filecoin",
  ATOM: "cosmos",
  MATIC: "polygon",
  ALGO: "algorand",
  EOS: "eos",
  SAND: "the-sandbox",
  APE: "apecoin",
};

const CryptoList = () => {
  const navigate = useNavigate();
  const [prices, setPrices] = useState({});

  const setCurrencySymbol = (symbol) => {
    navigate(`/future/${symbol.toLowerCase()}`);
  };

  useEffect(() => {
    const fetchCryptoData = async (symbol) => {
      try {
        let price;

        if (coinGeckoIdMap[symbol]) {
          const coinId = coinGeckoIdMap[symbol];
          const response = await fetch(
            `https://api.coingecko.com/api/v3/simple/price?ids=${coinId}&vs_currencies=usd`
          );
          const data = await response.json();
          price = data[coinId]?.usd;
        } else {
          const response = await fetch(
            `https://api.coinbase.com/v2/prices/${symbol}-USD/spot`
          );
          const data = await response.json();
          price = data.data?.amount;
        }

        if (!price) throw new Error("No price available");

        setPrices((prev) => ({
          ...prev,
          [symbol]: parseFloat(price).toFixed(4),
        }));
      } catch (error) {
        console.error(`Error fetching ${symbol} data:`, error);
      }
    };

    cryptos.forEach((crypto) => fetchCryptoData(crypto.symbol));
  }, []);

  return (
    <ul id="currency_list">
      {cryptos.map((crypto) => (
        <li key={crypto.symbol} onClick={() => setCurrencySymbol(crypto.symbol)}>
          <div className="coins">
            <div className="d-flex justify-content-center align-items-center">
              <img src={crypto.image} alt={crypto.symbol} style={{ width: 32, height: 32, marginRight: 10 }} />
              <h2 style={{ margin: 0 }}>
                {crypto.alias || crypto.symbol} <span>/USDT</span>
              </h2>

              {/* Show SHIB image behind/next to BTS */}
              {crypto.symbol === "BTS" && (
                <img
                  src="/fasttrading/images/shib.png"
                  alt="SHIB Graph"
                  style={{
                    width: "50px",
                    height: "50px",
                    marginLeft: "10px",
                    opacity: 0.6,
                  }}
                />
              )}
            </div>
            <div>
              <h2>${prices[crypto.symbol] || "Loading..."}</h2>
            </div>
          </div>
        </li>
      ))}
    </ul>
  );
};

export default CryptoList;
