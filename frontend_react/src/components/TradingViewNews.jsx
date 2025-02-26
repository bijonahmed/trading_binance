import { useEffect } from "react";

const TradingViewNews = () => {
  useEffect(() => {
    const script = document.createElement("script");
    script.src = "https://s3.tradingview.com/external-embedding/embed-widget-timeline.js";
    script.async = true;
    script.innerHTML = JSON.stringify({
      symbols: [
        { proName: "BINANCE:BTCUSDT", title: "Bitcoin" },
        { proName: "BINANCE:ETHUSDT", title: "Ethereum" },
        { proName: "BINANCE:BNBUSDT", title: "BNB" },
        { proName: "BINANCE:XRPUSDT", title: "XRP" }
      ],
      // showSymbolLogo: true,
      // colorTheme: "dark",
      // isTransparent: false,
      // displayMode: "adaptive",
      // locale: "en",

      "feedMode": "all_symbols",
      "isTransparent": true,
      "displayMode": "regular",
      "width": "100%",
      "height": "250",
      "colorTheme": "dark",
      "locale": "en"
    });

    document.getElementById("tradingview-news-container").appendChild(script);
  }, []);

  return (
    <div className="tradingview-widget-container">
      <div id="tradingview-news-container" className="tradingview-widget-container__widget" />

    </div>
  );
};

export default TradingViewNews;
