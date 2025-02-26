import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import Navbar from "../components/Navbar";
import Footer from "../components/Footer";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import LeftSideBarComponent from "../components/LeftSideBarComponent";
import LeftSideBarComponentPlt from "../components/LeftSideBarComponentAlllGames";
import Loader from "../components/Loader";
import AuthUser from "../components/AuthUser";
import axios from "/config/axiosConfig";
import QRCode from "qrcode";

const WithdrawalHistory = () => {


  const [selectedCurrency, setSelectedCurrency] = useState("Bitcoin");
  const [currencyImage, setCurrencyImage] = useState(
    "https://cryptologos.cc/logos/bitcoin-btc-logo.png"
  );
  //const [getQrcode, setQrCode] = useState("");
  const [waAddress, setAddress] = useState("");
  const [loading, setLoading] = useState(true);
  const [dateForm, setDateForm] = useState("");
  const [dateTo, setDateTo] = useState("");
  const [depositData, setHistory] = useState([]);
  const [selectedStatus, setSelectedStatus] = useState("");

  const handleDateChangeFrm = (event) => {
    setDateForm(event.target.value); // Update state with the selected date
  };

  const handleDateChangeTo = (event) => {
    setDateTo(event.target.value); // Update state with the selected date
  };

  const navigate = useNavigate();

  const { user } = AuthUser();
  const { getToken, token, logout } = AuthUser();

  const getDepositHistoryReport = async () => {
    setLoading(true);

    try {
      const tokens = JSON.parse(sessionStorage.getItem("token"));
      if (!tokens) throw new Error("Token is missing.");

      const params = {
        tokens: tokens,
        frm: dateForm,
        to: dateTo,
        status: selectedStatus,
      };
      const response = await axios.get("/withdrawal/withdrawalHistoryReport", {
        headers: {
          Authorization: `Bearer ${tokens}`,
          "Content-Type": "application/json",
        },
        params: params,
      });
      //console.log("Response received:", response.data.data);
      setHistory(response.data.data);
    } catch (error) {
      console.error("Error:", error);
      //  alert(error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleStatusChange = (e) => {
    setSelectedStatus(e.target.value);
    console.log("Selected Status:", e.target.value); // For debugging
  };

  const getStatusLabel = (status) => {
    switch (status) {
      case 1:
        return "Active";
      case 0:
        return "Pending";
      case 2:
        return "Reject";
      default:
        return "Unknown";
    }
  };

  const getStatusColor = (status) => {
    switch (status) {
      case 1:
        return "primary"; // Active (Blue)
      case 0:
        return "warning"; // Pending (Yellow)
      case 2:
        return "danger"; // Reject (Red)
      default:
        return "secondary"; // Unknown (Gray)
    }
  };
  useEffect(() => {
    getDepositHistoryReport();
    if (!user) {
      navigate("/login"); // Redirect to the login page if `user` is null or undefined
    }
  }, [user, navigate]);
  return (
    <>
      <Helmet>
        <title>Withdrawal History</title>
      </Helmet>
      <div style={{ height: 54 }} />
      <Navbar />

      <div className="container-fluid" style={{ minHeight: "100vh" }}>
        <div className="row">
          <div className="col-2" style={{ marginTop: "-50px" }}>
            <LeftSideBarComponent />
          </div>
          <div className="col-8 mt-4">
            <div className="row">
              <div className="col-l2">
                <center></center>
                <div style={{ marginTop: "-10px" }}>
                  <div>
                    <div className="row">
                      <div className="col-12">
                        <div className="top_bar">
                          <div>
                            <Link to="/deposit-amount">
                              <i className="fa-solid fa-chevron-left" />
                            </Link>
                          </div>
                          <div>
                            <h5>Withdrawal History</h5>
                          </div>
                          <div></div>
                        </div>

                        {/* Start */}
                        <div className="row">
                          <div className="co-md-6 col-sm-12 col-12">
                            {/* dimond purches history */}
                            <div className="trasnsection_history">
                              <div className="history_title">
                                <div className="d-flex" />
                                {/* <div> <a href="deposite.html"><i class="fa-solid fa-arrow-right"></i></a></div> */}
                              </div>
                              <div className="row filter">
                                <div className="col-lg-12">
                                  <div className="row">
                                    <div className="col-10">
                                    <div className="row align-items-center g-2">
  {/* Date From */}
  <div className="col-md-3">
    <input
      type="date"
      value={dateForm}
      onChange={handleDateChangeFrm}
      className="form-control"
    />
  </div>

  {/* "To" Label */}
  <div className="col-md-1 text-center">
    <h5 className="mb-0">To</h5>
  </div>

  {/* Date To */}
  <div className="col-md-3">
    <input
      type="date"
      value={dateTo}
      onChange={handleDateChangeTo}
      className="form-control"
    />
  </div>

  {/* Status Dropdown */}
  <div className="col-md-3">
    <select
      className="form-control"
      value={selectedStatus}
      onChange={handleStatusChange}
    >
      <option value="">Select Status</option>
      <option value="0">Pending</option>
      <option value="1">Active</option>
      <option value="2">Reject</option>
    </select>
  </div>

  {/* Search Button */}
  <div className="col-md-2 justify-content-end">
    <button
      className="btn btn-primary w-100"
      onClick={() => getDepositHistoryReport()}
    >
      Search
    </button>
  </div>
</div>

                                    </div>
                                  </div>
                                </div>
                              </div>

                              {loading ? (
                                <Loader /> // Show loader while data is loading
                              ) : (
                                <table className="table">
                                  <thead>
                                    <tr>
                                      <th>Deposit ID</th>
                                      <th>Date</th>
                                      <th className="text-center">
                                        Game Platform
                                      </th>
                                      <th>Amount</th>
                                      <th>Wallet Address</th>
                                      <th>Status</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {depositData.map((deposit, index) => (
                                      <tr
                                        key={index}
                                        style={{ fontSize: "12px" }}
                                      >
                                        <td>{deposit.withdrawID}</td>
                                        <td>{deposit.withdrawa_date}</td>
                                        <td className="text-center">
                                          {deposit.gamePltName}
                                        </td>
                                        <td className="text-success">
                                          {deposit.currencyName}&nbsp;
                                          {`${deposit.withdrawal_amount}`}
                                        </td>
                                        <td className="text-danger">
                                          {deposit.wallet_address}
                                        </td>
                                        <td
                                          className={`badge text-${getStatusColor(
                                            deposit.status
                                          )}`}
                                        >
                                          <div style={{ color: "black" }}>
                                            {getStatusLabel(deposit.status)}
                                          </div>
                                        </td>
                                      </tr>
                                    ))}
                                  </tbody>
                                </table>
                              )}
                            </div>
                            {/* dimond purches history end here  */}
                          </div>
                        </div>

                        {/* END */}
                      </div>
                    </div>
                    {/* nav end  */}
                    {/* bank country part start here  */}
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div className="col-2" style={{ marginTop: "-50px" }}>
            <LeftSideBarComponentPlt />
          </div>
        </div>
      </div>

      <div className="container">
        <div className="row ">
          <div className="col-md-12" style={{ height: 90 }} />
        </div>
      </div>
      <Footer />
    </>
  );
};

export default WithdrawalHistory;
