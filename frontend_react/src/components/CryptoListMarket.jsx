import { useEffect, useState, useRef } from "react";

const cryptos = [
  { symbol: "bitcoin", name: "BTC/USDT", image: "/fasttrading/images/bitcoin.png" },
  { symbol: "ethereum", name: "ETH/USDT", image: "/fasttrading/images/eth.png" },
  { symbol: "ripple", name: "XRP/USDT", image: "/fasttrading/images/xrp.png" },
  { symbol: "cardano", name: "ADA/USDT", image: "/fasttrading/images/ada.png" },
  { symbol: "solana", name: "SOL/USDT", image: "/fasttrading/images/sol.png" },
  { symbol: "polkadot", name: "DOT/USDT", image: "/fasttrading/images/dot.png" },
  { symbol: "dogecoin", name: "DOGE/USDT", image: "/fasttrading/images/doge.png" },
  { symbol: "shiba-inu", name: "SHIB/USDT", image: "/fasttrading/images/shib.png" },
  { symbol: "litecoin", name: "LTC/USDT", image: "/fasttrading/images/ltc.png" },
  { symbol: "chainlink", name: "LINK/USDT", image: "/fasttrading/images/link.png" },
  { symbol: "avalanche-2", name: "AVAX/USDT", image: "/fasttrading/images/avax.png" },
  { symbol: "uniswap", name: "UNI/USDT", image: "/fasttrading/images/uni.png" },
  { symbol: "stellar", name: "XLM/USDT", image: "/fasttrading/images/xlm.png" },
  { symbol: "vechain", name: "VET/USDT", image: "/fasttrading/images/vet.png" },
  { symbol: "tron", name: "TRX/USDT", image: "/fasttrading/images/trx.png" },
  // { symbol: "ICP", name: "ICP/USDT", image: "/fasttrading/images/ICP.webp" },
  // { symbol: "NEAR", name: "NEAR/USDT", image: "/fasttrading/images/near.png" },
  // { symbol: "FIL", name: "FIL/USDT", image: "/fasttrading/images/filecoin.webp" },
  // { symbol: "BCH", name: "BCH/USDT", image: "/fasttrading/images/bitcoin-cash-circle.webp" },
  // { symbol: "BTS", name: "BTS/USDT", image: "/fasttrading/images/bts.png" },
  // { symbol: "ALGO", name: "ALGO/USDT", image: "/fasttrading/images/algo.webp" },
  // { symbol: "EOS", name: "EOS/USDT", image: "/fasttrading/images/eos.png" },
  // { symbol: "APE", name: "APE/USDT", image: "/fasttrading/images/apecoin.jpg" },
];

const CryptoList = () => {
  const [prices, setPrices] = useState({});
  const [volumes, setVolumes] = useState({});
  const [changes, setChanges] = useState({});
  const chartRefs = useRef({});

  useEffect(() => {
    const fetchCryptoData = async () => {
      try {
        const symbols = cryptos.map((crypto) => crypto.symbol).join(",");
        const url = `https://api.coingecko.com/api/v3/simple/price?ids=${symbols}&vs_currencies=usd&include_24hr_change=true&include_24hr_vol=true`;
  
        const response = await fetch(url);
        const data = await response.json();
  
        const newPrices = {};
        const newVolumes = {};
        const newChanges = {};
  
        cryptos.forEach((crypto) => {
          const id = crypto.symbol;
          if (data[id]) {
            newPrices[id] = data[id].usd?.toFixed(2) || "0.00";
            newVolumes[id] = data[id].usd_24h_vol?.toFixed(2) || "0.00";
            newChanges[id] = data[id].usd_24h_change?.toFixed(2) || "0.00";
          }
        });
  
        setPrices(newPrices);
        setVolumes(newVolumes);
        setChanges(newChanges);
      } catch (error) {
        console.error("Error fetching crypto data:", error);
      }
    };

    const fetchHistoricalData = async (symbol) => {
      try {
        const url = `https://api.coingecko.com/api/v3/coins/${symbol}/market_chart?vs_currency=usd&days=30&interval=daily`;
        const response = await fetch(url);
        const data = await response.json();

        if (!data || !data.prices)
          throw new Error("No historical data received");

        const pricesArray = data.prices.map((entry) => entry[1]); // Extract prices
        const firstPrice = pricesArray[0];
        const lastPrice = pricesArray[pricesArray.length - 1];
        const changePercent = ((lastPrice - firstPrice) / firstPrice) * 100;

        setChanges((prev) => ({ ...prev, [symbol]: changePercent.toFixed(2) }));

        renderChart(symbol, pricesArray);
      } catch (error) {
        console.error(`Error fetching historical data for ${symbol}:`, error);
      }
    };

    // Fetch both current & historical data
    const updateCryptoData = () => {
      fetchCryptoData();
      cryptos.forEach(({ symbol }) => fetchHistoricalData(symbol));
    };

    updateCryptoData();
    const interval = setInterval(updateCryptoData, 5000); // Refresh every 5 sec

    return () => clearInterval(interval); // Cleanup
  }, []);

  // Define renderChart to generate the charts
  const renderChart = (symbol, pricesArray) => {
    const canvas = document.getElementById(`${symbol}Chart`);
    if (!canvas) return;

    const ctx = canvas.getContext("2d");

    // Check if a chart already exists and destroy it
    if (chartRefs.current[symbol]) {
      chartRefs.current[symbol].destroy();
    }

    const chart = new Chart(ctx, {
      type: "line",
      data: {
        labels: pricesArray.map((_, i) => i + 1),
        datasets: [
          {
            data: pricesArray,
            borderColor: "blue",
            backgroundColor: "rgba(0, 0, 255, 0.1)",
            borderWidth: 2,
            pointRadius: 0,
            fill: true,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: { x: { display: false }, y: { display: false } },
      },
    });

    // Save the chart instance
    chartRefs.current[symbol] = chart;
  };

  return (
    <tbody>
      {cryptos.map((crypto, index) => (
        <tr key={crypto.symbol}>
          <td className="text-center pc_view">{index + 1}</td>
          <td>
            <div className="d-flex">
              <div>
                <img src={crypto.image} alt={crypto.name} />
              </div>
              <div>
                <h5 className=" mb-0">{crypto.name}</h5>
                <p className="mobile_view mb-0">
                  Volume: {volumes[crypto.symbol] || "0000.000"}
                </p>
                <p className="mobile_view mb-0">
                  Price: ${prices[crypto.symbol] || "Loading..."}
                </p>
              </div>
            </div>
          </td>
          <td className="pc_view text-center">
            {volumes[crypto.symbol] || "0000.000"}
          </td>
          <td className="pc_view text-center">
            ${prices[crypto.symbol] || "Loading..."}
          </td>
          {/* <td>
            <div className="chart-container">
              <canvas id={`${crypto.symbol}Chart`}></canvas>
            </div>
          </td> */}
          <td>
            <a
              href="#"
              className={`btn_charge btn ${
                changes[crypto.symbol] >= 0 ? "btn-success" : "btn-danger"
              }`}
            >
              {changes[crypto.symbol] ? `${changes[crypto.symbol]}%` : "NaN"}
            </a>
          </td>
        </tr>
      ))}
    </tbody>
  );
};

export default CryptoList;
