import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import Sidebar from "../../components/SidebarAuth";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import AuthGuard from "../../components/AuthGuard";
import AuthUser from "../../components/AuthUser";
import Loader from "../../components/Loader";
const TradeHistory = () => {
  const { token, logout } = AuthUser();
  const [loading, setLoading] = useState(false);
  const [currentBalance, setCurrentBalance] = useState("");
  const [findTrns, searchTrxno] = useState("");
  const [dateForm, setDateForm] = useState("");
  const [dateTo, setDateTo] = useState("");
  const [tradeData, setTradeData] = useState([]);
  const [type, setSelectType] = useState("");
  const [currency, setCurrency] = useState("");

  // ============================= get balance =======================
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

  const handleTxt = (event) => {
    searchTrxno(event.target.value);
  };
  const handleFrnDate = (event) => {
    setDateForm(event.target.value);
  };
  const handleType = (event) => {
    setSelectType(event.target.value);
  };

  const handleToDate = (event) => {
    setDateTo(event.target.value);
  };

  const getClass = (closingPNL) =>
    closingPNL < 0 ? "text-danger" : "text-success text-success";
  const getTradeList = async () => {
    setLoading(true);
    try {
      // Get the current date
      const currentDate = new Date();
      currentDate.setDate(currentDate.getDate() + 2); // Add 2 days
      const EnDate = currentDate.toISOString().split("T")[0]; // Format to yyyy-mm-dd
      // Get the date 30 days ago
      const pastDate = new Date();
      pastDate.setDate(currentDate.getDate() - 30);
      const startDate = pastDate.toISOString().split("T")[0]; // Format to yyyy-mm-dd
      const params = {
        filterFrmDate: dateForm || startDate,
        filterToDate: dateTo || EnDate,
        searchtxt: findTrns,
        type: type,
      };
      const response = await axios.get("/trade/filterTradeHistory", {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        params: params,
      });
      //console.log("Response received:", response.data.data);
      setTradeData(response.data.data);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    getCurrentBalance();
    getTradeList();
  }, []);

  return (
    <>
      <Helmet>
        <title>Trade History</title>
      </Helmet>

      <div>
        {/* Sidebar Start */}
        <Sidebar />
        {/* Sidebar End */}

        <div className="main_dashboard">
          {/* Top Navbar */}
          <NavbarAuth />
          <AuthGuard />
          {/* Top Navbar End */}

          {/* Start */}
          <div className="dashboard_content">
            <div className="row">
              <div className="col-md-12">
                <div className="payment_section">
                  <div className="page_title">
                    <a
                      href="#"
                      className="btn_back"
                      click="history.back(); return false;"
                    >
                      <i className="fa-solid fa-arrow-left" />
                    </a>
                  </div>
                </div>
                {/* balance */}
                <div className="balance_container">
                  <div className="balance_box">
                    <h5>Estimated Balance</h5>
                    <h4>
                      {currentBalance}
                      <span>&nbsp;USDT</span>{" "}
                    </h4>
                    {/* <h6>$0.00</h6> */}
                  </div>
                  <div className="row">
                    <div className="col-md-8 ms-auto">
                      <div className="btns_list">
                        {/* data-bs-toggle="modal" data-bs-target="#deposit_modal"  */}
                        <Link
                          to="/dashboard/deposit"
                          role="button"
                          className="btn_primary"
                        >
                          Deposit
                        </Link>
                        <Link to="/dashboard/withdraw" className="btn_primary">
                          Withdraw
                        </Link>
                        {/* <a href="" class="btn_primary"></a> */}
                      </div>
                    </div>
                  </div>
                </div>
                {/* history section start here  */}
                <div className="page_title">
                  <div className="d-flex justify-content-between w-100 align-items-end">
                    <h4>Trade History</h4>
                  </div>
                </div>
                <center>
                  {loading ? (
                    <div>
                      <Loader />
                      <center>
                        {" "}
                        <span>Loading.....</span>
                      </center>
                    </div>
                  ) : (
                    <div className="row">
                      <div className="col-md-6 m-auto"></div>
                    </div>
                  )}
                </center>
                <div className="row">
                  <div className="col-md-12">
                    <div className="search_section">
                      <form action="">
                        <div className="search_div">
                          <div className="row g-3">
                            {/* Search & Type Filter */}
                            <div className="col-12 col-md-6">
                              <div className="d-flex flex-column flex-md-row align-items-center gap-2 w-100">
                                <div className="input_form w-100">
                                  <input
                                    type="text"
                                    placeholder="Search Order ID"
                                    className="form-control"
                                    value={findTrns}
                                    onChange={handleTxt}
                                  />
                                </div>
                                <div className="input_form w-100">
                                  <select
                                    className="form-control"
                                    value={type}
                                    onChange={handleType}
                                  >
                                    <option value="">All</option>
                                    <option value="LONG">Long</option>
                                    <option value="SHORT">Short</option>
                                  </select>
                                </div>
                              </div>
                            </div>

                            {/* Date Range & Filter Button */}
                            <div className="col-12 col-md-6">
                              <div className="d-flex flex-column flex-md-row align-items-center gap-2 justify-content-md-start justify-content-center">
                                <div className="input_form date_">
                                  <input
                                    type="date"
                                    value={dateForm}
                                    onChange={handleFrnDate}
                                    className="form-control"
                                  />
                                </div>
                                <p className="d-none d-md-block">TO</p>
                                <div className="input_form date_">
                                  <input
                                    type="date"
                                    value={dateTo}
                                    onChange={handleToDate}
                                    className="form-control"
                                  />
                                </div>
                                <button
                                  type="button"
                                  onClick={getTradeList}
                                  className="btn_primary mt-2 mt-md-0"
                                >
                                  Filter
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </form>
                    </div>
                    <div className="table-responsive">
                      <ul className="transec_tb_mobile trande_ mobile_view">
                        {tradeData && tradeData.length > 0 ? (
                          <ul className="ps-0 list-unstyled">
                            {tradeData.map((trade, index) => (
                              <li
                                key={index}
                                className="border p-2 mb-2 bg-dark text-white rounded"
                              >
                                <p>
                                  <strong>Order ID:</strong> {trade.tradeID}
                                </p>
                                <p>
                                  <strong>Perp Cross:</strong>{" "}
                                  {trade.selectedCurrency}USDT
                                </p>
                                <p>
                                  <strong>Type:</strong>{" "}
                                  <span
                                    className={`badge ${
                                      trade.action_type === "LONG"
                                        ? "bg-success"
                                        : "bg-danger"
                                    }`}
                                  >
                                    {trade.action_type}
                                  </span>
                                </p>
                                <p>
                                  <strong>Amount (USDT):</strong>{" "}
                                  {trade.trade_amount}
                                </p>
                                <p>
                                  <strong>Entry Price:</strong> $
                                  {trade.market_price}
                                </p>
                                <p>
                                  <strong>Open:</strong> {trade.start_datetime}
                                </p>
                                <p>
                                  <strong>Close Price:</strong> $
                                  {trade.close_price || "0.00"}
                                </p>
                                <p>
                                  <strong>Close:</strong> {trade.end_datetime}
                                </p>
                                <p>
                                  <strong>Fee:</strong> ${trade.fee}
                                </p>
                                <p>
                                  <strong>PNL:</strong>{" "}
                                  <span className={getClass(trade.closingPNL)}>
                                    {trade.closingPNL}
                                  </span>
                                </p>
                              </li>
                            ))}
                          </ul>
                        ) : (
                          <p>No trade data available.</p>
                        )}
                      </ul>
                      {tradeData && tradeData.length > 0 ? (
                        <table className="table table-dark table-striped table-hover pc_view">
                          <thead>
                            <tr>
                              <th className="col">OrderID</th>
                              <th>Perp Cross</th>
                              <th>Type</th>
                              <th>Amount(USDT)</th>
                              <th>Entry Price</th>
                              <th>Open Time</th>
                              <th>Close Price</th>
                              <th>Close</th>
                              <th>Fee</th>
                              <th>Closing PNL</th>
                            </tr>
                          </thead>
                          <tbody>
                            {tradeData.map((trade, index) => (
                              <tr key={index}>
                                <td>{trade.tradeID}</td>
                                <td>{trade.selectedCurrency}USDT</td>
                                <td>
                                  <span
                                    className={
                                      trade.action_type === "LONG"
                                        ? "badge bg-success"
                                        : "badge bg-danger"
                                    }
                                  >
                                    {trade.action_type}
                                  </span>
                                </td>

                                <td>{trade.trade_amount}</td>
                                <td>{trade.market_price}</td>
                                <td>{trade.start_datetime}</td>
                                <td>{trade.close_price || 0.0}</td>
                                <td>{trade.end_datetime}</td>
                                <td>{trade.fee}</td>
                                <td className={getClass(trade.closingPNL)}>
                                  {trade.closingPNL}
                                </td>
                              </tr>
                            ))}
                          </tbody>
                        </table>
                      ) : (
                        <p>No trade data available.</p>
                      )}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* END */}
        </div>
      </div>
    </>
  );
};

export default TradeHistory;
