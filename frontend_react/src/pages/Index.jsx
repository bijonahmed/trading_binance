// src/pages/Index.js
import React, { useState, useEffect, useContext } from "react";
import { Helmet } from "react-helmet";
import { Link } from "react-router-dom";
import "../components/css/CryptoTable.css";
import TradingViewNews from "../components/TradingViewNews";
import Loader from "../components/Loader";
import axios from "/config/axiosConfig";
import Navbar from "../components/Navbar";
import Faq from "../components/Faq";
import Footer from "../components/Footer";


// import Chart from "chart.js/auto";

const cryptos = [
  { symbol: "BTC", name: "BTC/USDT", image: "/fasttrading/images/btc.png" },
  { symbol: "ETH", name: "ETH/USDT", image: "/fasttrading/images/eth.png" },
  { symbol: "BNB", name: "BNB/USDT", image: "/fasttrading/images/bnb.png" },
  { symbol: "XRP", name: "XRP/USDT", image: "/fasttrading/images/xrp.png" },
];

const Index = () => {
  const [cryptoData, setCryptoData] = useState({});
  const getRandomStart = () => 212436053 + Math.floor(Math.random() * 1001) - 500;
  
  const [userCount, setUserCount] = useState(getRandomStart()); // Initialize with random value

  useEffect(() => {
    const interval = setInterval(() => {
      setUserCount((prevCount) => prevCount + Math.floor(Math.random() * 5) + 1); // Increase by 1-5
    }, 1000);

    return () => clearInterval(interval); // Cleanup on unmount
  }, []);

  useEffect(() => {
    const fetchCryptoData = async (symbol) => {
      try {
        const response = await fetch(
          `https://api.binance.com/api/v3/ticker/24hr?symbol=${symbol}USDT`
        );
        const data = await response.json();
        setCryptoData((prev) => ({
          ...prev,
          [symbol]: {
            price: parseFloat(data.lastPrice).toFixed(2),
            volume: `Vol: ${parseFloat(data.volume).toFixed(2)}`,
            change: `${parseFloat(data.priceChangePercent).toFixed(2)}%`,
            isPositive: parseFloat(data.priceChangePercent) >= 0,
          },
        }));
      } catch (error) {
        console.error(`Error fetching ${symbol} data:`, error);
      }
    };

      // Fetch data every second
  const interval = setInterval(() => {
    cryptos.forEach(({ symbol }) => fetchCryptoData(symbol));
  }, 4000); // 1-second interval


    cryptos.forEach(({ symbol }) => fetchCryptoData(symbol));
  }, []);
  

  return (
    <div>
      <Helmet>
        <title>Welcome to Fast Trading</title>
      </Helmet>

      {/* Start */}

      <div>
        <Navbar />
        {/* header part end here  */}
        {/* hero part start herer  */}
        <section className="hero_part">
          <div className="container">
            <div className="row">
              <div className="col-lg-6">
                <div className="hero_content">
                  <h1>
                    <span>{userCount.toLocaleString()}</span> {/* Format number */}
                    <strong>Trade with </strong>
                    <strong>Confidence</strong>
                  </h1>
                  <div className="row">
                    <div className="col-xl-8 me-auto">
                      <div className="form_group_register">
                        <input
                          type="text"
                          className="form-control d-none d-md-block"
                          placeholder="Email"
                        />
                         <Link to="/register" className="btn_primary">
                          Sign up
                        </Link>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div className="col-lg-6">
                <div className="row">
                  <div className="col-12">
                    <div className="coin_table">

                      <ul className="coin_list" id="crypto-table">
                        <div className="d-flex justify-content-between align-items-center">
                          <h6 className="m-0">Popular</h6>
                        </div>
                        {cryptos.map(({ symbol, name, image }) => (
                          <li key={symbol}>
                            <a className="coin_link">
                              <span className="coin_icon">
                                <img src={image} alt={name} className="img-fluid" />
                                <strong>{name}</strong>
                                {/* <span>{name}</span> */}
                              </span>
                              <span>
                                {cryptoData[symbol]?.price ? `$${cryptoData[symbol]?.price}` : "Loading..."}
                              </span>
                              <span className={cryptoData[symbol]?.change < 0 ? "negative" : "positive"}>
                                {cryptoData[symbol]?.change || "N/A"}%
                              </span>
                            </a>
                          </li>
                        ))}
                      </ul>
                    </div>
                  </div>
                  <div className="col-12">
                    <div className="coin_table">
                      {/* TradingView Widget BEGIN */}
                      <TradingViewNews />
                      {/* TradingView Widget END */}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        {/* hero part end here  */}
        {/* mobile view image section start here  */}
        <section className="mobile_img">
          <div className="container">
            <div className="row">
              <div className="col-md-6">
                <div className="img_section">
                  <img
                    src="/fasttrading/images/mobile_view.png"
                    alt="img"
                    className="img"
                  />
                </div>
              </div>
              <div className="col-md-6">
                <div className="img_sec_title">
                  <h2>Trade on the go. Anywhere, anytime.</h2>
                  <img
                    src="/fasttrading/images/desktop_view.png"
                    alt="img"
                    className="img-fluid"
                  />
                </div>
              </div>
            </div>
          </div>
        </section>
        {/* mobile view image section end herer  */}
        {/* faq section start here  */}
        <Faq />
        {/* faq section end here  */}
        {/* sign up section  */}
        <div className="newslatter_sec">
          <div className="container">
            <div className="row">
              <div className="col-md-12">
                <div className="signUp_sectin">
                  <h4>Start earning today</h4>
                  <Link to="/register" className="btn_primary">
                    Sign up now
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </div>
        {/* footer part start here  */}
        <Footer />
      </div>

      {/* END */}
    </div>
  );
};

export default Index;
