import React, { useState, useRef, useEffect } from "react";
import { Helmet } from "react-helmet";
import Navbar from "../components/Navbar";
import Footer from "../components/Footer";
import CryptoList from "../components/CryptoList";
import TradingViewMarket from "../components/TradingViewMarket";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import { useParams } from "react-router-dom";
import AuthUser from "../components/AuthUser";
import axios from "/config/axiosConfig";

const Future = () => {
  const [errors, setErrors] = useState({});
  const navigate = useNavigate();
  const { token, logout } = AuthUser();
  const durations = [60, 120, 180, 300];
  const percentages = [25, 50, 75, 100];

  const { slug } = useParams();
  const upperCaseCurrency = slug.toUpperCase();
  const marketSymbol = `BINANCE:${upperCaseCurrency}USDT`;
  //console.log(marketSymbol);
  const [currentBalance, setCurrentBalance] = useState("");
  const [marketpriceAmount, setMarketPriceAmount] = useState(0);
  const [tradeAmount, setTradeAmount] = useState("");
  const [selectedDuration, setSelectedDuration] = useState(null);
  const [selectedPercentage, setSelectedPercentage] = useState(null);
  const [marketPrice, setMarketPrice] = useState("");
  const [amount, setAmount] = useState("");
  const [actionType, setActionType] = useState(null); // To track if Long or Short is selected
  //
  const getCurrentBalance = async () => {
    try {
      const response = await axios.get(`/balance/getCurrentBalance`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      });
      const balance = response.data.balance;
      setCurrentBalance(balance);
    } catch (error) {
      console.error("Error Data:", error);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      localStorage.setItem("selected_duration", selectedDuration);
      const formData = {
        market_price: marketpriceAmount,
        trade_amount: tradeAmount,
        selected_duration: selectedDuration,
        selected_percentage: selectedPercentage,
        action_type: actionType,
        selectedCurrency: slug,
      };
      
  
      const response = await axios.post("/trade/insertTrade",
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );
      const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.onmouseenter = Swal.stopTimer;
          toast.onmouseleave = Swal.resumeTimer;
        },
      });
      Toast.fire({
        icon: "success",
        title: "Your trade has been successfully started.",
      });
 
      navigate(`/future-trading`)
      // closeModal();
    } catch (error) {
      if (error.response.data.errors.invalid_amount) {
        Swal.fire({
          icon: "error",
          title: "Invalid Request",
          html: `<div>${error.response.data.errors.invalid_amount.join("<br>")}</div>`,
        });
      } else {
        // Handle other validation errors
        Swal.fire({
          icon: "error",
          title: "Validation Errors",
          html: Object.values(error.response.data.errors)
            .map((err) => `<div>${err.join("<br>")}</div>`)
            .join(""),
        });
      }
    }

  };

  const handleDurationClick = (duration) => {
    setSelectedDuration(duration);
    const index = durations.indexOf(duration);
    if (index !== -1) {
      setSelectedPercentage(percentages[index]);
    }
  };

  const handlePercentageClick = (percentage) => {
    setSelectedPercentage(percentage);
  };

  //Trade Amount
  const handleMinusTradeAmount = () => {
    setTradeAmount((prev) => (prev ? Math.max(0, Number(prev) - 1) : 0));
  };

  const handlePlusTradeAmount = () => {
    setTradeAmount((prev) => (prev ? Number(prev) + 1 : 1));
  };
  const onlyTradeAmount = (e) => {
    const value = e.target.value;
    // Allow digits and a single optional decimal point
    if (/^\d*\.?\d*$/.test(value)) {
      setTradeAmount(value);
    }
  };
  //Market Price
  const handleMinusMarketPrice = () => {
    setMarketPriceAmount((prev) => (prev ? Math.max(0, Number(prev) - 1) : 0));
  };
  const handlePlusMarketPrice = () => {
    setMarketPriceAmount((prev) => (prev ? Number(prev) + 1 : 1));
  };
  const marketPriceAmount = (e) => {
    const value = e.target.value;
    if (/^\d*\.?\d*$/.test(value)) {
      setMarketPriceAmount(value);
    }
  };
  //Login
  const checkLogin = () => {
    $.notify("You can start trading after logging in!", "error");
    navigate("/login-trade");
  };
  useEffect(() => {
    getCurrentBalance();
    if (slug) {
      localStorage.setItem("currency_", slug);
    }
  }, [slug]);
  return (
    <>
      <Helmet>
        <title>Future</title>
      </Helmet>
      <Navbar />

      {/* start */}
      <div>
        <div className="container-fluid">
          <div className="row">
            <div className="col-md-4 hot_tab pc_view">
              <div className="row">
                <div className="col-12">
                  <div className="title">
                    <p className="mb-0 text-white">Currency List</p>
                  </div>
                  {/* favorite tab contnet  */}
                  {/* tab content here  */}
                  <div className="hot_part">
                    {/* <ul id="currency_list"></ul> */}
                    <CryptoList />
                  </div>
                  {/* tab content end here  */}
                </div>
              </div>
            </div>
            <div className="col-md-8">
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
                          <h1> {slug}/usdt</h1>
                        </div>
                      </div>
                    </div>
                  </div>
                  {/* topbar part end here  */}

                  {/* TradingView Widget BEGIN */}
                  <TradingViewMarket slug={marketSymbol} />
                  {/* TradingView Widget END */}
                </div>
                {/* chart part end here  */}

                {/* buy part start here  */}

                {token ? (
                  <>
                    <div className="col-md-12">
                      <div className="btns_part">
                        <form onSubmit={handleSubmit}>
                          {/* Start Market Price */}
                          <div className="btns d-none">
                            <div>
                              <button
                                type="button"
                                onClick={handleMinusMarketPrice}>
                                <i className="fa-solid fa-minus" />
                              </button>
                            </div>
                            <div>
                              <input
                                type="text"
                                placeholder="Market Price"
                                value={marketpriceAmount}
                                onChange={marketPriceAmount}
                              />
                    {errors.marketpriceAmount && (
                      <div className="error text-danger">{errors.marketpriceAmount}</div>
                    )}
 

                            </div>
                            <div>
                              <button
                                type="button"
                                onClick={handlePlusMarketPrice}
                              >
                                <i className="fa-solid fa-plus" />
                              </button>
                            </div>
                          </div>
                          {/* End Market Price */}

                          {/*Start Trade Amount*/}
                          <div className="btns">
                            <div>
                              <button
                                type="button"
                                onClick={handleMinusTradeAmount}
                              >
                                <i className="fa-solid fa-minus" />
                              </button>
                            </div>
                            <div>
                              <input
                                type="text"
                                placeholder="Trade Amount"
                                value={tradeAmount}
                                onChange={onlyTradeAmount}
                              />
                            </div>

                            <div>
                              <button
                                type="button"
                                onClick={handlePlusTradeAmount}
                              >
                                <i className="fa-solid fa-plus" />
                              </button>
                            </div>
                          </div>
                          {/*End Trade Amount*/}
                          <div className="btns justify-content-center">
                            <div>
                              <h4 className="text-center">Select Duration</h4>
                            </div>
                          </div>

                          <div className="row">
                            {durations.map((duration) => (
                              <div key={duration} className="col-3">
                                <div className="duration_btn">
                                  <button
                                    type="button"
                                    style={{
                                      backgroundColor:
                                        selectedDuration === duration
                                          ? "#007bff"
                                          : "#fff",
                                      color:
                                        selectedDuration === duration
                                          ? "#fff"
                                          : "#000",
                                      border: "1px solid #007bff",
                                      padding: "10px 15px",
                                      cursor: "pointer",
                                    }}
                                    onClick={() =>
                                      handleDurationClick(duration)
                                    }
                                  >
                                    {duration}s
                                  </button>
                                </div>
                              </div>
                            ))}
                          </div>
                          <div className="row">
                            {percentages.map((percentage) => (
                              <div key={percentage} className="col-3">
                                <div className="percen_btn">
                                  <button
                                    type="button"
                                    style={{
                                      backgroundColor:
                                        selectedPercentage === percentage
                                          ? "#007bff"
                                          : "#fff",
                                      color:
                                        selectedPercentage === percentage
                                          ? "#fff"
                                          : "#000",
                                      border: "1px solid #007bff",
                                      padding: "10px 15px",
                                      cursor: "pointer",
                                    }}
                                    onClick={() =>
                                      handlePercentageClick(percentage)
                                    }
                                  />
                                  <p>{percentage}%</p>
                                </div>
                              </div>
                            ))}
                          </div>

                          <div>
                            <h6 className="text-center avbl_css px-2">
                              <div className="d-flex justify-content-start align-items-center">
                                <div>Available Balance: &nbsp;</div>
                                <div className="mt-1">
                                  {currentBalance}<span>&nbsp;</span>
                                </div>
                              </div>
                            </h6>
                          </div>
                          <div className="d-flex aligh-items-center">
                            <button
                              type="submit"
                              onClick={() => setActionType("long")}
                              className="btn btn-success btn_show w-50 m-1"
                            >
                              Open Long{" "}
                            </button>
                            <button
                              type="submit"
                              onClick={() => setActionType("short")}
                              className="btn btn_show btn-danger w-50 m-1"
                            >
                              Open Short{" "}
                            </button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </>
                ) : (
                  <>
                    <div className="col-md-12" onClick={checkLogin}>
                      <div className="btns_part">
                        <form action="">
                          {/* Start Market Price */}
                          <div className="btns d-none">
                            <div>
                              <button type="button">
                                <i className="fa-solid fa-minus" />
                              </button>
                            </div>
                            <div>
                              <input type="text" placeholder="Market Price" />
                            </div>
                            <div>
                              <button type="button">
                                <i className="fa-solid fa-plus" />
                              </button>
                            </div>
                          </div>
                          {/* End Market Price */}

                          {/*Start Trade Amount*/}
                          <div className="btns">
                            <div>
                              <button type="button">
                                <i className="fa-solid fa-minus" />
                              </button>
                            </div>
                            <div>
                              <input type="text" placeholder="Trade Amount" />
                            </div>

                            <div>
                              <button type="button">
                                <i className="fa-solid fa-plus" />
                              </button>
                            </div>
                          </div>
                          {/*End Trade Amount*/}
                          <div className="btns justify-content-center">
                            <div>
                              <h4 className="text-center">Select Duration</h4>
                            </div>
                          </div>

                          <div className="row">
                            {durations.map((duration) => (
                              <div key={duration} className="col-3">
                                <div className="duration_btn">
                                  <button
                                    type="button"
                                    style={{
                                      backgroundColor:
                                        selectedDuration === duration
                                          ? "#007bff"
                                          : "#fff",
                                      color:
                                        selectedDuration === duration
                                          ? "#fff"
                                          : "#000",
                                      border: "1px solid #007bff",
                                      padding: "10px 15px",
                                      cursor: "pointer",
                                    }}
                                    onClick={() =>
                                      handleDurationClick(duration)
                                    }
                                  >
                                    {duration}s
                                  </button>
                                </div>
                              </div>
                            ))}
                          </div>
                          <div className="row">
                            {percentages.map((percentage) => (
                              <div key={percentage} className="col-3">
                                <div className="percen_btn">
                                  <button
                                    type="button"
                                    style={{
                                      backgroundColor:
                                        selectedPercentage === percentage
                                          ? "#007bff"
                                          : "#fff",
                                      color:
                                        selectedPercentage === percentage
                                          ? "#fff"
                                          : "#000",
                                      border: "1px solid #007bff",
                                      padding: "10px 15px",
                                      cursor: "pointer",
                                    }}
                                    onClick={() =>
                                      handlePercentageClick(percentage)
                                    }
                                  />
                                  <p>{percentage}%</p>
                                </div>
                              </div>
                            ))}
                          </div>

                          <div>
                            <h6 className="text-center avbl_css px-2">
                              <div className="d-flex justify-content-start align-items-center">
                                <div>Avbl: &nbsp;</div>
                                <div>
                                  1,000.00 <span>USDT</span>
                                </div>
                              </div>
                            </h6>
                          </div>
                          <div className="d-flex aligh-items-center">
                            <button
                              type="button"
                              className="btn btn-success btn_show w-50 m-1"
                            >
                              Open Long{" "}
                            </button>
                            <button
                              type="button"
                              className="btn btn_show btn-danger w-50 m-1"
                            >
                              Open Short{" "}
                            </button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </>
                )}

                {/* buy part end here  */}
              </div>
            </div>
          </div>
        </div>
        {/* Confirm modal  */}


        <div
          className="modal fade"
          id="open_long"
          tabIndex={-1}
          aria-labelledby="open_longLabel"
          style={{ display: "none" }}
          aria-hidden="true"
        >
          <div className="modal-dialog modal-dialog-centered">
            <div className="modal-content rounded-0">
              <div className="modal-header py-0">
                <div className="w-10" />
                {/* <h5 class="modal-title fs-6" id="open_longLabel"></h5> */}
                <div data-bs-theme="dark">
                  <button
                    type="button"
                    className="btn_close text-white"
                    data-bs-dismiss="modal"
                    aria-label="Close"
                  >
                    <i className="fas fa-times" />
                  </button>
                </div>
              </div>
              <div className="modal-body">
                <div className="text-center p-4 pb-2">
                  <i className="fa-solid fa-check confirm_icon" />
                  <h5 className="text-light">Your Trade has been started</h5>
                  <a href="market.html" className="btn_primary m_close my-3">
                    OK
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* END */}
    </>
  );
};

export default Future;
