import React, { useEffect, useRef } from "react";

const TradingViewWidgetXRPUSDT = () => {
  const widgetContainerRef = useRef(null);  // Create a reference to the container

  useEffect(() => {
    // Check if the component is mounted and the ref is available
    if (widgetContainerRef.current) {
      const script = document.createElement("script");
      script.src = "https://s3.tradingview.com/external-embedding/embed-widget-mini-symbol-overview.js";
      script.async = true;
      script.innerHTML = JSON.stringify({
        symbol: 'BINANCE:XRPUSDT',  // Symbol for XRPUSDT
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
  }, []);

  return (
    <div
      ref={widgetContainerRef} // Attach the ref here
      style={{ width: "100%", height: "100%" }}
    />
  );
};

export default TradingViewWidgetXRPUSDT;
