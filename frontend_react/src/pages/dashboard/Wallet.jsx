import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import Sidebar from "../../components/SidebarAuth";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import { useParams } from "react-router-dom";
import AuthGuard from "../../components/AuthGuard";
import AuthUser from "../../components/AuthUser";
import Loader from "../../components/Loader";

const Wallet = () => {
  //const [hasRequested, setHasRequested] = useState(false);
  const { token, logout } = AuthUser();
  const [images, setDepositImages] = useState("");
  const [loading, setLoading] = useState(false);
  const [currentBalance, setCurrentBalance] = useState("");

  //Withdraw
  const [witdrawTxt, setWithdrawTxt] = useState("");
  const [dateForm, setDateForm] = useState("");
  const [dateTo, setDateTo] = useState("");

  const [withdrawData, setWithdrawData] = useState([]);
  //Deposit
  const [de_depositTxt, setWithdrawTxtDeposit] = useState("");
  const [de_dateForm, setDateFormDeposit] = useState("");
  const [de_dateTo, setDateToDeposit] = useState("");
  const [depositData, setDepositData] = useState([]);
  const [bankInfo, setBankDetails] = useState("");
  const [transactionData, setTransData] = useState([]);

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

  // ============================= Depsoit =======================
  const handleWithdrawTxt_deposit = (event) => {
    setWithdrawTxtDeposit(event.target.value);
  };
  const handleDateChangeFrm_deposit = (event) => {
    setDateFormDeposit(event.target.value);
  };
  const handleDateChangeTo_deposit = (event) => {
    setDateToDeposit(event.target.value);
  };

  const getTransactionHistory = async () => {
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
        searchtxt: witdrawTxt,
      };
      const response = await axios.post(
        "/deposit/getTransactionHistory",
        {}, // Empty request body since params are sent in headers
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          params: params,
        }
      );
      //console.log("Response received:", response.data.data);
      setTransData(response.data.data);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setLoading(false);
    }
  };
  const getDepositList = async () => {
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
        filterFrmDate: de_dateForm || startDate,
        filterToDate: de_dateTo || EnDate,
        searchtxt: de_depositTxt,
      };
      const response = await axios.post(
        "/deposit/userDepositHistoryList",
        {}, // Empty request body since params are sent in headers
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          params: params,
        }
      );
      //console.log("Response received:", response.data.data);
      setDepositData(response.data.data);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setLoading(false);
    }
  };

  // ============================= Withdraw =======================
  const handleWithdrawTxt = (event) => {
    setWithdrawTxt(event.target.value);
  };
  const handleDateChangeFrm = (event) => {
    setDateForm(event.target.value);
  };
  const handleDateChangeTo = (event) => {
    setDateTo(event.target.value);
  };
  // const getWithdrawList = async () => {
  //   setLoading(true);
  //   try {
  //     // Get the current date
  //     const currentDate = new Date();
  //     currentDate.setDate(currentDate.getDate() + 2); // Add 2 days
  //     const EnDate = currentDate.toISOString().split("T")[0]; // Format to yyyy-mm-dd
  //     // Get the date 30 days ago
  //     const pastDate = new Date();
  //     pastDate.setDate(currentDate.getDate() - 30);
  //     const startDate = pastDate.toISOString().split("T")[0]; // Format to yyyy-mm-dd

  //     const params = {
  //       filterFrmDate: dateForm || startDate,
  //       filterToDate: dateTo || EnDate,
  //       searchtxt: witdrawTxt,
  //     };
  //     const response = await axios.post(
  //       "/withdrawal/userWithdrawalHistoryList",
  //       {}, // Empty request body since params are sent in headers
  //       {
  //         headers: {
  //           Authorization: `Bearer ${token}`,
  //           "Content-Type": "application/json",
  //         },
  //         params: params,
  //       }
  //     );
  //     //console.log("Response received:", response.data.data);
  //     setWithdrawData(response.data.data);
  //   } catch (error) {
  //     console.error("Error:", error);
  //   } finally {
  //     setLoading(false);
  //   }
  // };

  useEffect(() => {
    getTransactionHistory();
    getCurrentBalance();
    // getWithdrawList();
    //getDepositList();
  }, []);

  return (
    <>
      <Helmet>
        <title>Wallet</title>
      </Helmet>

      <div>
        {/* Sidebar Start */}
        <Sidebar />
        <AuthGuard />
        {/* Sidebar End */}

        <div className="main_dashboard">
          {/* Top Navbar */}
          <NavbarAuth />
          {/* Top Navbar End */}

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
                    <div className="d-flex justify-content-between w-100 align-items-end">
                      <h4>Wallet</h4>
                    </div>
                  </div>
                </div>
                {/* balance */}
                <div className="balance_container">
                  <div className="balance_box">
                    <h5>Estimated Balance</h5>
                    <h4>
                      {currentBalance}&nbsp;<span></span>{" "}
                    </h4>
                    {/* <h6>$0.00</h6> */}
                  </div>
                  <div className="row">
                    <div className="col-md-8 ms-auto">
                      <div className="btns_list">
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
                      </div>
                    </div>
                  </div>
                </div>
                {/* history section start here  */}
                <div className="page_title">
                  <div className="d-flex justify-content-between w-100 align-items-end">
                    <h4>Transection history</h4>
                  </div>
                </div>
                <div className="tabs_buttons">
                  <ul
                    className="nav nav-pills mb-3"
                    id="pills-tab"
                    role="tablist"
                  >
                    <li className="nav-item" role="presentation">
                      <button
                        className="nav-link active"
                        id="withdrawtabs"
                        data-bs-toggle="pill"
                        data-bs-target="#withdraw"
                        type="button"
                        role="tab"
                        aria-controls="pills-home"
                        aria-selected="true"
                      >
                      
                      </button>
                    </li>
                  </ul>
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
                <div className="tab-content" id="pills-tabContent">
                  <div
                    className="tab-pane fade show active"
                    id="withdraw"
                    role="tabpanel"
                    aria-labelledby="pills-home-tab"
                    tabIndex={0}
                  >
                    <div className="row">
                      <div className="col-md-12">
                        <div className="search_div">
                          <div className="row">
                            <div className="col-12 col-md-6 mb-2">
                              <div className="input_form m-0">
                                <input
                                  type="text"
                                  placeholder="Search Order ID"
                                  className="form-control"
                                  value={witdrawTxt}
                                  onChange={handleWithdrawTxt} // ✅ Required to update state
                                  onKeyUp={(e) =>
                                    console.log("Key Up:", e.target.value)
                                  } // ✅ Works when a key is released
                                />
                              </div>
                            </div>

                            <div className="col-12 col-md-6 d-flex flex-column flex-md-row align-items-center justify-content-center justify-content-md-start">
                              <div className="input_form date_ mb-2 mb-md-0">
                                <input
                                  type="date"
                                  className="form-control"
                                  value={dateForm}
                                  onChange={handleDateChangeFrm}
                                />
                              </div>
                              <p className="mx-2 mb-2 mb-md-0">TO</p>
                              <div className="input_form date_ mb-2 mb-md-0">
                                <input
                                  type="date"
                                  className="form-control"
                                  value={dateTo}
                                  onChange={handleDateChangeTo}
                                />
                              </div>
                              <button
                                type="button"
                                onClick={getTransactionHistory}
                                className="btn_primary mt-2 mt-md-0"
                              >
                                Search
                              </button>
                            </div>
                          </div>
                        </div>
                        <div className="transection_table table-responsive">
                          {/* withdrawData */}
                          <ul className="transec_tb_mobile mobile_view">
                            {transactionData.map((data) => (
                              <li key={data.id}>
                                <p>ID: {data.id}</p>
                                <p>
                                  <span
                                    style={{
                                      color: "#fff",
                                      backgroundColor:
                                        data.adjustment_type === 1
                                          ? "green"
                                          : data.adjustment_type === 2
                                          ? "red"
                                          : "transparent",
                                      fontSize: "15px",
                                      padding: "5px 10px",
                                      borderRadius: "10px",
                                      display: "inline-block",
                                    }}
                                  >
                                    {data.adjustment_type === 1 ||
                                    data.adjustment_type === 2
                                      ? `Amt: ${data.adjustment_amount}`
                                      : ""}
                                  </span>
                                </p>

                                <p>DATE: {data.created_at}</p>
                                <p>
                                  <br />
                                  <span
                                    className="d-none"
                                    style={{
                                      color: "#fff",
                                      backgroundColor:
                                        data.adjustment_type === 1
                                          ? "green"
                                          : data.adjustment_type === 2
                                          ? "red"
                                          : "transparent",
                                      fontSize: "15px",
                                      padding: "5px 10px",
                                      borderRadius: "10px",
                                      display: "inline-block",
                                    }}
                                  >
                                    {data.adjustment_type === 1
                                      ? "Debit (+)"
                                      : data.adjustment_type === 2
                                      ? "Debit (-)"
                                      : ""}
                                  </span>
                                </p>
                              </li>
                            ))}
                          </ul>
                          <table className="table table-striped table-dark pc_view">
                            <thead>
                              <tr>
                                <th>ID</th>
                                <th className="text-center">Date</th>
                                <th className="text-center">Amount</th>
                                <th className="text-center">Reason</th>
                              </tr>
                            </thead>
                            <tbody>
                              {transactionData.map((data) => (
                                <tr key={data.id}>
                                  <td>{data.id}</td>
                                  <td className="text-center">
                                    {data.created_at}
                                  </td>

                                  <td className="text-center">
                                    {data.detailed_remarks}
                                  </td>
                                  <td className="text-center">
                                    {data.adjustment_type === 1 && (
                                      <div
                                        style={{
                                          color: "#fff",
                                          backgroundColor: "green",
                                          fontSize: "15px",
                                          padding: "5px 10px",
                                          borderRadius: "10px",
                                          display: "inline-block",
                                        }}
                                      >
                                        {data.adjustment_amount}
                                      </div>
                                    )}

                                    {data.adjustment_type === 2 && (
                                      <div
                                        style={{
                                          color: "#fff",
                                          backgroundColor: "red",
                                          fontSize: "15px",
                                          padding: "5px 10px",
                                          borderRadius: "10px",
                                          display: "inline-block",
                                        }}
                                      >
                                        {data.adjustment_amount}
                                      </div>
                                    )}
                                  </td>
                                </tr>
                              ))}
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Dashboard Content End */}

          {/* add new modal start here  */}
          <div
            className="modal fade"
            id="paymentModal"
            tabIndex={-1}
            aria-labelledby="boostModalLabel"
            aria-modal="true"
            role="dialog"
          >
            <div className="modal-dialog modal-dialog-centered">
              <div className="modal-content rounded-0">
                <div className="modal-header py-0">
                  <div className="w-10"> </div>
                  <h5 className="modal-title fs-6" id="boostModalLabel" />
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
                  <div className="table-responsive">
                    {bankInfo.payment_method == "BANK" && (
                      <>
                        <center className="text-white">
                          <p>Bank Details</p>
                        </center>
                        <table className="table table-hover">
                          <tbody>
                            <tr>
                              <td>
                                <strong>Currency Symbol</strong>
                              </td>
                              <td>{bankInfo.currencySymbol}</td>
                            </tr>
                            <tr>
                              <td>
                                <strong>Bank Name</strong>
                              </td>
                              <td>{bankInfo.bank_name}</td>
                            </tr>
                            <tr>
                              <td>
                                <strong>Account Name</strong>
                              </td>
                              <td>{bankInfo.account_name}</td>
                            </tr>
                            <tr>
                              <td>
                                <strong>Account Number</strong>
                              </td>
                              <td>{bankInfo.account_number}</td>
                            </tr>
                            {bankInfo.ific_code && (
                              <>
                                <tr>
                                  <td>
                                    <strong>IFIC Code</strong>
                                  </td>
                                  <td>{bankInfo.ific_code}</td>
                                </tr>
                              </>
                            )}

                            {bankInfo.swift_code && (
                              <>
                                <tr>
                                  <td>
                                    <strong>SWIFT Code</strong>
                                  </td>
                                  <td>{bankInfo.swift_code}</td>
                                </tr>
                              </>
                            )}

                            {bankInfo.others_code && (
                              <>
                                <tr>
                                  <td>
                                    <strong>Others Code</strong>
                                  </td>
                                  <td>{bankInfo.others_code}</td>
                                </tr>
                              </>
                            )}

                            <tr>
                              <td>
                                <strong>Input Amount</strong>
                              </td>
                              <td>{bankInfo.inputAmount}</td>
                            </tr>
                          </tbody>
                        </table>
                      </>
                    )}
                  </div>

                  <div className="form_group">
                    <div className="st_filter">
                      {images ? (
                        <center>
                          <img
                            src={images}
                            className="img-fluid rounded"
                            width="100%"
                            alt="Deposit"
                          />
                        </center>
                      ) : (
                        <p>No image available</p>
                      )}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Wallet;
