import React, { useState, useRef, useEffect } from "react";
import { Helmet } from "react-helmet";
import Navbar from "../components/Navbar";
import Footer from "../components/Footer";
import CryptoList from "../components/CryptoList";
import TradingViewMarket from "../components/TradingViewMarket";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";

import AuthUser from "../components/AuthUser";
import axios from "/config/axiosConfig";

const Future = () => {
  //const [getQrcode, setQrCode] = useState("");
  const [hasRequested, setHasRequested] = useState(false);

  useEffect(() => {}, []);

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
                          <h1>
                            {" "}
                            btc/usdt <span>+0.50%</span>
                          </h1>
                          <div className="min_btns">
                            <button type="button" className="btn btn_time">
                              10min
                            </button>
                            <button type="button" className="btn btn_time">
                              30min
                            </button>
                            <button type="button" className="btn btn_time">
                              45min
                            </button>
                            <button type="button" className="btn btn_time">
                              1Hour
                            </button>
                            <button type="button" className="btn btn_time">
                              1day
                            </button>
                            <button type="button" className="btn btn_time">
                              1Week
                            </button>
                            <button type="button" className="btn btn_time">
                              1Month
                            </button>
                          </div>
                        </div>
                      </div>
                      <div className="col-2 d-flex justify-content-end align-items-center">
                        <div className="top_right">
                          <div className="candle_icon pc_view">
                            <a href="#">
                              <img
                                src="/fasttrading/images/candle.png"
                                className="candle_light"
                                alt="Images"
                              />
                              <img
                                src="/fasttrading/images/candle dark.png"
                                className="candle_dark"
                                alt="Images"
                              />
                            </a>
                          </div>
                          <div className="candle_icon mobile_view">
                            <a>
                              <button
                                className="d-flex justify-content-center align-items-center btn_candle"
                                id="myButton"
                                click="toggleButton"
                              >
                                <img
                                  src="/fasttrading/images/candle-active.png"
                                  className=" icn_active"
                                  alt="Images"
                                />
                                <img
                                  src="/fasttrading/images/candle.png"
                                  className=" icn_inactive"
                                  alt="Images"
                                />
                              </button>
                            </a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  {/* topbar part end here  */}

                  {/* TradingView Widget BEGIN */}
                  <TradingViewMarket />
                  {/* TradingView Widget END */}
                </div>
                {/* chart part end here  */}
                {/* buy part start here  */}
                <div className="col-md-12">
                  <div className="btns_part">
                    <form action="">
                      <div className="btns">
                        <select className="text-center">
                          <option>Limite </option>
                          <option>Market</option>
                        </select>
                      </div>
                      <div className="btns">
                        <div>
                          <button>
                            <i className="fa-solid fa-minus" />
                          </button>
                        </div>
                        <div>
                          <h4 className="text-center">24,000.00</h4>
                        </div>{" "}
                        {/*(Buying Price)*/}
                        <div>
                          <button>
                            <i className="fa-solid fa-plus" />
                          </button>
                        </div>
                      </div>
                      <div className="btns">
                        <div>
                          <button>
                            <i className="fa-solid fa-minus" />
                          </button>
                        </div>
                        <div>
                          <input type="text" placeholder="Ammount(BTC)" />
                        </div>
                        {/*Est BTC ammount*/}
                        <div>
                          <button>
                            <i className="fa-solid fa-plus" />
                          </button>
                        </div>
                      </div>
                      <div className="btns justify-content-center">
                        <div>
                          <h4 className="text-center">Select Duration</h4>
                        </div>
                      </div>
                      <div className="row">
                        <div className="col-3">
                          <div className="duration_btn">
                            <div>
                              <button type="button">30s</button>
                            </div>
                          </div>
                        </div>
                        <div className="col-3">
                          <div className="duration_btn">
                            <div>
                              <button type="button">60s</button>
                            </div>
                          </div>
                        </div>
                        <div className="col-3">
                          <div className="duration_btn">
                            <div>
                              <button type="button">120s</button>
                            </div>
                          </div>
                        </div>
                        <div className="col-3">
                          <div className="duration_btn">
                            <div>
                              <button type="button">300s</button>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div className="row">
                        <div className="col-3">
                          <div className="percen_btn">
                            <div>
                              <button type="button" />
                            </div>
                            <div>
                              <p>25%</p>
                            </div>
                          </div>
                        </div>
                        <div className="col-3">
                          <div className="percen_btn">
                            <div>
                              <button type="button" />
                            </div>
                            <div>
                              <p>50%</p>
                            </div>
                          </div>
                        </div>
                        <div className="col-3">
                          <div className="percen_btn">
                            <div>
                              <button type="button" />
                            </div>
                            <div>
                              <p>75%</p>
                            </div>
                          </div>
                        </div>
                        <div className="col-3">
                          <div className="percen_btn">
                            <div>
                              <button type="button" />
                            </div>
                            <div>
                              <p>100%</p>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div className="btns justify-content-center">
                        <div>
                          <h4 className="text-center"> 0.00</h4>
                        </div>
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
                          data-bs-toggle="modal"
                          data-bs-target="#open_long"
                          className="btn btn-success btn_show w-50 m-1"
                        >
                          Open Long{" "}
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="modal"
                          data-bs-target="#open_long"
                          className="btn btn_show btn-danger w-50 m-1"
                        >
                          Open Short{" "}
                        </button>
                      </div>
                    </form>
                  </div>
                </div>
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
