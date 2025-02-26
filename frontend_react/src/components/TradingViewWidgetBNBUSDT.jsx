import React, { useEffect, useRef } from "react";

const TradingViewWidgetBNBUSDT = () => {
  const widgetContainerRef = useRef(null);  // Create a reference to the container

  useEffect(() => {
    // Ensure the DOM element is available before proceeding
    if (widgetContainerRef.current) {
      const script = document.createElement("script");
      script.src = "https://s3.tradingview.com/external-embedding/embed-widget-mini-symbol-overview.js";
      script.async = true;
      script.innerHTML = JSON.stringify({
        symbol: 'BINANCE:BNBUSDT',  // Set symbol to BNBUSDT
        width: "100%",
        height: "100%",
        locale: "en",
        dateRange: "3M",
        colorTheme: "dark",
        isTransparent: false,
        autosize: true,
        largeChartUrl: "",
        chartOnly: false,
        noTimeScale: false,
      });

      // Append the script to the container
      widgetContainerRef.current.appendChild(script);

      // Cleanup script when the component unmounts
      return () => {
        if (widgetContainerRef.current) {
          widgetContainerRef.current.removeChild(script);
        }
      };
    }
  }, []);  // Empty dependency array ensures this effect runs once when the component is mounted

  return (
    <div
      ref={widgetContainerRef}  // Attach the ref here
      style={{ width: "100%", height: "100%" }}
    />
  );
};

export default TradingViewWidgetBNBUSDT;
