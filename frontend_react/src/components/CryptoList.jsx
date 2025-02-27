import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
const cryptos = [
  { symbol: "BTC", name: "BTC/USDT", image: "/fasttrading/images/bitcoin.png" },
  { symbol: "ETH", name: "ETH/USDT", image: "/fasttrading/images/eth.png" },
  { symbol: "BNB", name: "BNB/USDT", image: "/fasttrading/images/bnb.png" },
  { symbol: "XRP", name: "XRP/USDT", image: "/fasttrading/images/xrp.png" },
  { symbol: "ADA", name: "ADA/USDT", image: "/fasttrading/images/ada.png" },
  { symbol: "SOL", name: "SOL/USDT", image: "/fasttrading/images/sol.png" },
  { symbol: "DOT", name: "DOT/USDT", image: "/fasttrading/images/dot.png" },
  { symbol: "DOGE", name: "DOGE/USDT", image: "/fasttrading/images/doge.png" },
  { symbol: "SHIB", name: "SHIB/USDT", image: "/fasttrading/images/shib.png" },
  { symbol: "LTC", name: "LTC/USDT", image: "/fasttrading/images/ltc.png" },
  { symbol: "LINK", name: "LINK/USDT", image: "/fasttrading/images/link.png" },
  { symbol: "AVAX", name: "AVAX/USDT", image: "/fasttrading/images/avax.png" },
  { symbol: "UNI", name: "UNI/USDT", image: "/fasttrading/images/uni.png" },
  { symbol: "XLM", name: "XLM/USDT", image: "/fasttrading/images/xlm.png" },
  { symbol: "VET", name: "VET/USDT", image: "/fasttrading/images/vet.png" },
  { symbol: "TRX", name: "TRX/USDT", image: "/fasttrading/images/trx.png" },
];

const CryptoList = () => {
  const navigate = useNavigate();
  const [prices, setPrices] = useState({});
  const [volumes, setVolumes] = useState({});
  const [changes, setChanges] = useState({});

  const setCurrencySymbol = (symbol) => {
    const currencySymbol = symbol.toLowerCase();
    console.log(currencySymbol);
    navigate(`/future/${currencySymbol}`);
  };

  useEffect(() => {
    const fetchCryptoData = async (symbol) => {
      const endTime = Date.now();
      const startTime = endTime - 30 * 24 * 60 * 60 * 1000; // Last 30 days
      const url = `https://api.binance.com/api/v3/klines?symbol=${symbol}USDT&interval=1d&startTime=${startTime}&endTime=${endTime}&limit=30`;

      try {
        const response = await fetch(url);
        const data = await response.json();
        if (!data || data.length === 0) throw new Error("No data received");

        const pricesArray = data.map((entry) => parseFloat(entry[4])); // Closing price
        const volumesArray = data.map((entry) => parseFloat(entry[5])); // Volume

        const firstPrice = pricesArray[0];
        const lastPrice = pricesArray[pricesArray.length - 1];
        const changePercent = ((lastPrice - firstPrice) / firstPrice) * 100;

        setPrices((prev) => ({ ...prev, [symbol]: lastPrice.toFixed(2) }));
        setVolumes((prev) => ({
          ...prev,
          [symbol]: volumesArray[volumesArray.length - 1].toFixed(2),
        }));
        setChanges((prev) => ({ ...prev, [symbol]: changePercent.toFixed(2) }));
      } catch (error) {
        console.error(`Error fetching ${symbol} data:`, error);
      }
    };

    cryptos.forEach((crypto) => fetchCryptoData(crypto.symbol));
  }, []);

  return (
    <ul id="currency_list">
      {cryptos.map((crypto) => (
        <li
          key={crypto.symbol}
          onClick={() => setCurrencySymbol(crypto.symbol)}
        >
          <div className="coins">
            <div className="d-flex justify-content-center align-items-center">
              <div>
                <img src={crypto.image} alt={crypto.symbol} />
              </div>
              <div>
                <h2>
                  {crypto.symbol} <span>/USDT</span>
                </h2>
                <p>Volume: {volumes[crypto.symbol] || "0000.000"}</p>
              </div>
            </div>
            <div>
              <h2>${prices[crypto.symbol] || "Loading..."}</h2>
              <p
                className={`text-end ${
                  changes[crypto.symbol] >= 0 ? "text-success" : "text-danger"
                }`}
              >
                {changes[crypto.symbol] ? `${changes[crypto.symbol]}%` : "NaN"}
              </p>
            </div>
          </div>
        </li>
      ))}
    </ul>
  );
};

export default CryptoList;
