import { useEffect, useRef } from "react";

const TradingViewMarket = ({ slug }) => {
  const containerRef = useRef(null);
  console.log("TradingViewMarket Component: " + slug);

  useEffect(() => {
    if (!window.TradingView) {
      const script = document.createElement("script");
      script.src = "https://s3.tradingview.com/tv.js";
      script.async = true;
      script.onload = () => createWidget(slug);
      document.body.appendChild(script);
    } else {
      createWidget(slug);
    }

    function createWidget(symbol) {
      if (containerRef.current && window.TradingView) {
        new window.TradingView.widget({
          autosize: true,
          symbol: symbol, // Dynamic symbol from prop
          interval: "1",
          timezone: "Etc/UTC",
          theme: "dark",
          style: "1",
          locale: "en",
          toolbar_bg: "#f1f3f6",
          enable_publishing: false,
          backgroundColor: "rgba(8, 19, 34, 1)",
          hide_top_toolbar: true,
          hide_legend: true,
          save_image: false,
          container_id: "tradingview_container",
        });
      }
    }
  }, [slug]); // Re-run effect when `slug` changes

  return (
    <>
      <div className="tradingview-widget-container futures_widgets">
        <div id="tradingview_container" ref={containerRef}></div>
        <div className="tradingview-widget-copyright">
          <a
            href="https://www.tradingview.com/"
            rel="noopener nofollow"
            target="_blank"
          >
            <span className="blue-text">Track all markets on TradingView</span>
          </a>
        </div>
      </div>
    </>
  );
};

export default TradingViewMarket;
