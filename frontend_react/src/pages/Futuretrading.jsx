import React, { useState, useRef, useEffect } from "react";
import { Helmet } from "react-helmet";
import Navbar from "../components/Navbar";

import CryptoList from "../components/CryptoList";
import TradingViewMarket from "../components/TradingViewMarket";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import { useParams } from "react-router-dom";
import AuthUser from "../components/AuthUser";
import AuthGuard from "../components/AuthGuard";
import LoaderMultiSquare from "../components/LoaderMultiSquare";
import axios from "/config/axiosConfig";
import "../components/css/Countdown.css"; // Import your CSS file

const Futuretrading = () => {
  const navigate = useNavigate();
  const { token, logout } = AuthUser();
  const [timeLeft, setTimeLeft] = useState(0);
  const [currency, setCurrency] = useState(null); // To track if Long or Short is selected
  const [tradeSettings, setTradeSettings] = useState(null); // To track if Long or Short is selected
  useEffect(() => {
    const savedSettings = JSON.parse(localStorage.getItem("tradeSettings"));
    if (savedSettings) {
      setTradeSettings({
        marketSymbol: savedSettings.marketSymbol || "",
        actionType: savedSettings.actionType || "",
        tradeAmount: savedSettings.tradeAmount || "",
        selectedDuration: savedSettings.selectedDuration || "",
      });
    }

    const crr = localStorage.getItem("currency_");
    setCurrency(crr);

    const duration = localStorage.getItem("selected_duration");
    if (duration) {
      setTimeLeft(parseInt(duration)); // Set initial countdown time from localStorage
    }

    const interval = setInterval(() => {
      setTimeLeft((prevTime) => {
        if (prevTime > 0) {
          return prevTime - 1; // Decrease time each second
        } else {
          clearInterval(interval); // Cleanup interval when time is up
          return 0;
        }
      });
    }, 1000);

    // Cleanup interval if component unmounts or if countdown ends
    return () => clearInterval(interval);
  }, []);

  // Handle countdown completion and perform cleanup
  useEffect(() => {
    if (timeLeft === 0) {
      localStorage.removeItem("selected_duration"); // Remove selected_duration from localStorage
    }
  }, [timeLeft, navigate]); // Dependency on `timeLeft` ensures redirect happens after countdown finishes

  //navigate("/dashboard/wallet");  // Redirect to wallet/dashboard

  return (
    <>
      <Helmet>
        <title>Future Trading</title>
      </Helmet>
      <Navbar />
      <AuthGuard />

      {/* start */}
      <div>
        <div className="container-fluid">
          <div className="row">
            <div className="col-md-12">
              <div className="row">
                {/* chart part start here  */}
                <div className="col-md-12">
                  {/* topbar part start here  */}
                  <div className="top_navbar">
                    <div className="row ">
                      <div className="col-10">
                        <div className="top_left">
                          <div>
                            <a
                              data-bs-toggle="offcanvas"
                              href="#offcanvasExample"
                              role="button"
                              aria-controls="offcanvasExample"
                            >
                              <img
                                src="/fasttrading/images/arrow.png"
                                alt="Images"
                              />
                            </a>
                            <div
                              className="offcanvas offcanvas-start"
                              tabIndex={-1}
                              id="offcanvasExample"
                              aria-labelledby="offcanvasExampleLabel"
                            >
                              <div className="offcanvas-header pb-0">
                                <div className="d-flex justify-content-between align-items-center mb-0">
                                  <h5
                                    className="offcanvas-title"
                                    id="offcanvasExampleLabel"
                                  >
                                    Markets
                                  </h5>
                                  <button
                                    type="button "
                                    className="btn_close"
                                    data-bs-dismiss="offcanvas"
                                    aria-label="Close"
                                  >
                                    <i className="fa-solid fa-xmark" />
                                  </button>
                                </div>
                                <hr className="text-white pb-0" />
                                <div className="d-none">
                                  <form action="">
                                    <input
                                      type="text"
                                      name="search"
                                      placeholder="search"
                                      className="form-control"
                                    />
                                  </form>
                                </div>
                              </div>
                              <div className="offcanvas-body">
                                {/*tab  main content part start here  */}
                                <div className="tab_function">
                                  {/* Currency part start here  */}
                                  <div className="col-md-12 ">
                                    <div
                                      className="nav flex-column nav-pills"
                                      role="tablist"
                                      id="mbcurrency_list"
                                      aria-orientation="vertical"
                                    >
                                      <CryptoList />
                                    </div>
                                  </div>
                                  {/* Currency part end here  */}
                                </div>
                                {/* tabs part end here    */}
                              </div>
                            </div>
                          </div>
                          {/* Coin title  */}
                          <h1>{currency}</h1>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                {/* chart part end here  */}

                {/* buy part start here  */}

                {token ? (
                  <>
                    <div className="col-md-12">
                      <div className="btns_part2">
                        <div className="countdown-container">
                          {timeLeft > 0 ? (
                            <>
                              <h1 className="countdown-text">
                                Please Wait... {timeLeft}s
                                <center>
                                  <LoaderMultiSquare />
                                </center>
                              </h1>

                              <div className="container mt-4">
                             
                              <div className="container mt-4" style={{ backgroundColor: '#181a20', color: 'white', padding: '20px' }}>

  <ul style={{ listStyleType: 'none', padding: 0 }}>
    <li style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '10px' }}>
      <strong>CROSS </strong>
      <span>{tradeSettings.marketSymbol?.replace("BINANCE:", "").toUpperCase()}</span>
    </li>
    <li style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '10px' }}>
      <strong>CYCLE </strong>
      <span>{tradeSettings.selectedDuration}s</span>
    </li>
    
    <li style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '10px' }}>
      <strong>DIRECTION </strong>
      <span>{tradeSettings.actionType}</span>
    </li>
    <li style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '10px' }}>
      <strong>QUANTITY </strong>
      <span>{tradeSettings.tradeAmount}</span>
    </li>
   
  </ul>
</div>

                           

                              </div>
                              {timeLeft === 0 && (
                                <p className="time-up-text">Time's up!</p>
                              )}
                            </>
                          ) : (
                            <div className="back-to-home">
                              <button
                                onClick={() =>
                                  navigate("/dashboard/trade-history")
                                }
                                className="btn_secondary btn-btn-large"
                              >
                                Check Trade History
                              </button>
                            </div>
                          )}
                        </div>
                      </div>
                    </div>
                  </>
                ) : null}

                {/* buy part end here  */}
              </div>
            </div>
          </div>
        </div>
        {/* Confirm modal  */}
      </div>

      {/* END */}
    </>
  );
};

export default Futuretrading;
