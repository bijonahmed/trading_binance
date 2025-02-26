import { useEffect, useState, useRef } from "react";
// import Chart from "chart.js/auto";

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
  const [prices, setPrices] = useState({});
  const [volumes, setVolumes] = useState({});
  const [changes, setChanges] = useState({});
  const chartRefs = useRef({});

  useEffect(() => {
    const fetchCryptoData = async (symbol) => {
      const endTime = Date.now();
      const startTime = endTime - 30 * 24 * 60 * 60 * 1000;
      const url = `https://api.binance.com/api/v3/klines?symbol=${symbol}USDT&interval=1d&startTime=${startTime}&endTime=${endTime}&limit=30`;

      try {
        const response = await fetch(url);
        const data = await response.json();
        if (!data || data.length === 0) throw new Error("No data received");

        const pricesArray = data.map((entry) => parseFloat(entry[4]));
        const volumesArray = data.map((entry) => parseFloat(entry[5]));

        const firstPrice = pricesArray[0];
        const lastPrice = pricesArray[pricesArray.length - 1];
        const changePercent = ((lastPrice - firstPrice) / firstPrice) * 100;

        setPrices((prev) => ({ ...prev, [symbol]: lastPrice.toFixed(2) }));
        setVolumes((prev) => ({ ...prev, [symbol]: volumesArray[volumesArray.length - 1].toFixed(2) }));
        setChanges((prev) => ({ ...prev, [symbol]: changePercent.toFixed(2) }));

        renderChart(symbol, pricesArray);
      } catch (error) {
        console.error(`Error fetching ${symbol} data:`, error);
      }
    };

    const updateCryptoData = () => {
      cryptos.forEach(({ symbol }) => fetchCryptoData(symbol));
    };

    updateCryptoData();
    // const interval = setInterval(updateCryptoData, 1000);

    return () => updateCryptoData();
      // clearInterval(interval);
  }, []);

  const renderChart = (symbol, pricesArray) => {
    const canvas = document.getElementById(`${symbol.toLowerCase()}Chart`);
    if (!canvas) return;
    const ctx = canvas.getContext("2d");

    if (chartRefs.current[symbol]) {
      chartRefs.current[symbol].destroy();
    }

    chartRefs.current[symbol] = new window.Chart(ctx, {
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
                <p className="mobile_view mb-0">Volume: {volumes[crypto.symbol] || "0000.000"}</p>
                <p className="mobile_view mb-0">Price: ${prices[crypto.symbol] || "Loading..."}</p>
              </div>
            </div>
          </td>
          <td className="pc_view text-center">{volumes[crypto.symbol] || "0000.000"}</td>
          <td className="pc_view text-center">${prices[crypto.symbol] || "Loading..."}</td>
          <td>
            <div className="chart-container">
              <canvas id={`${crypto.symbol.toLowerCase()}Chart`}></canvas>
            </div>
          </td>
          <td>
            <a
              href="future.html"
              className={`btn_charge btn ${changes[crypto.symbol] >= 0 ? "btn-success" : "btn-danger"}`}
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
