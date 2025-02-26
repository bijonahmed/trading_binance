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

  const getMoneyReceipt = async (depositId) => {
    const params = {
      depositId: depositId,
    };
    const response = await axios.post(
      "/deposit/checkDepositrow",
      {}, // Empty request body since params are sent in headers
      {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        params: params,
      }
    );
    console.log("Deposit Data:", response.data);
    setBankDetails(response.data);
    setDepositImages(response.data.depsoit_images);
  };

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
  const getWithdrawList = async () => {
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
        "/withdrawal/userWithdrawalHistoryList",
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
      setWithdrawData(response.data.data);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    getCurrentBalance();
    getWithdrawList();
    getDepositList();
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
                      {currentBalance}&nbsp;<span>USDT</span>{" "}
                    </h4>
                    <h6>$0.00</h6>
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
                        Withdraw
                      </button>
                    </li>
                    <li className="nav-item" role="presentation">
                      <button
                        className="nav-link"
                        id="deposittab"
                        data-bs-toggle="pill"
                        data-bs-target="#deposit"
                        type="button"
                        role="tab"
                        aria-controls="pills-profile"
                        aria-selected="false"
                      >
                        Deposit
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
                            <div className="col-md-6">
                              <div className="input_form mb-2 m-0">
                                <input
                                  type="text"
                                  placeholder="Search TRX id"
                                  className="form-control"
                                  value={witdrawTxt}
                                  onChange={handleWithdrawTxt} // ✅ Required to update state
                                  onKeyUp={(e) =>
                                    console.log("Key Up:", e.target.value)
                                  } // ✅ Works when a key is released
                                />
                              </div>
                            </div>
                            <div className="col-md-6">
                              <div className="d-flex align-items-center justify-content-md-start justify-content-center">
                                <div className="input_form date_">
                                  <input
                                    type="date"
                                    className="form-control mb-2"
                                    value={dateForm}
                                    onChange={handleDateChangeFrm}
                                  />
                                </div>
                                <p className="mx-2">TO</p>
                                <div className="input_form date_ m-0">
                                  <input
                                    type="date"
                                    className="form-control mb-2"
                                    value={dateTo}
                                    onChange={handleDateChangeTo}
                                  />
                                </div>
                                <p className="mx-2"></p>
                                <button
                                  type="button"
                                  onClick={getWithdrawList}
                                  className="btn_primary"
                                  style={{ marginTop: "-7px" }}
                                >
                                  Filter
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div className="transection_table table-responsive">
                          {/* withdrawData */}
                          <ul className="transec_tb_mobile mobile_view">
                            {withdrawData.map((withdraw) => (
                              <li key={withdraw.withdrawID}>
                                <p>ID: {withdraw.withdrawID}</p>
                                <p>Amt: ${withdraw.withdrawal_amount}</p>
                                <p>DATE: {withdraw.withdrawa_date}</p>
                                <p>
                                  Fee: $0.00
                                  <br />
                                  <span
                                    className={`badge ${
                                      withdraw.status == 0
                                        ? "bg-warning text-dark"
                                        : withdraw.status == 1
                                        ? "bg-success"
                                        : "bg-danger"
                                    }`}
                                  >
                                    {withdraw.status == 0
                                      ? "Pending"
                                      : withdraw.status == 1
                                      ? "Approve"
                                      : "Rejected"}
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
                                <th className="text-center">Fee</th>
                                <th className="text-center">Status</th>
                              </tr>
                            </thead>
                            <tbody>
                              {withdrawData.map((withdraw) => (
                                <tr key={withdraw.withdrawID}>
                                  <td>{withdraw.withdrawID}</td>
                                  <td className="text-center">
                                    {withdraw.withdrawa_date}
                                  </td>
                                  <td className="text-center">
                                    ${withdraw.withdrawal_amount}
                                  </td>
                                  <td className="text-center">0.00</td>
                                  <td className="text-center">
                                    <span
                                      className={`badge ${
                                        withdraw.status == 0
                                          ? "bg-warning text-dark"
                                          : withdraw.status == 1
                                          ? "bg-success"
                                          : "bg-danger"
                                      }`}
                                    >
                                      {withdraw.status == 0
                                        ? "Pending"
                                        : withdraw.status == 1
                                        ? "Approve"
                                        : "Rejected"}
                                    </span>
                                  </td>
                                </tr>
                              ))}
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    className="tab-pane fade"
                    id="deposit"
                    role="tabpanel"
                    aria-labelledby="pills-profile-tab"
                    tabIndex={0}
                  >
                    <div className="row">
                      <div className="col-md-12">
                        <div className="search_div">
                          <div className="row">
                            <div className="col-md-6">
                              <div className="input_form mb-2 m-0">
                                <input
                                  type="text"
                                  placeholder="Search TRX id"
                                  className="form-control"
                                  value={de_depositTxt}
                                  onChange={handleWithdrawTxt_deposit} // ✅ Required to update state
                                  onKeyUp={(e) =>
                                    console.log("Key Up:", e.target.value)
                                  } // ✅ Works
                                />
                              </div>
                            </div>
                            <div className="col-md-6">
                              <div className=" d-flex align-items-center justify-content-md-start justify-content-center">
                                <div className="input_form date_ ">
                                  <input
                                    type="date"
                                    className="form-control"
                                    value={de_dateForm}
                                    onChange={handleDateChangeFrm_deposit}
                                  />
                                </div>
                                <p className="text-white my-0 mx-2">TO</p>
                                <div className="input_form date_  m-0">
                                  <input
                                    type="date"
                                    className="form-control"
                                    value={de_dateTo}
                                    onChange={handleDateChangeTo_deposit}
                                  />
                                </div>
                                <p className="mx-2"></p>
                                <button
                                  type="button"
                                  onClick={getDepositList}
                                  className="btn_primary"
                                  style={{ marginTop: "-7px" }}
                                >
                                  Filter
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div className="transection_table table-responsive">
                          <ul className="transec_tb_mobile mobile_view">
                            {depositData.map((deposit) => (
                              <li key={deposit.id}>
                                <p>ID:&nbsp;{deposit.depositID}</p>
                                <p>Amt: ${deposit.deposit_amount}</p>
                                <p>DATE: {deposit.deposit_date}</p>
                                <p>
                                  <span
                                    className={`badge ${
                                      deposit.status == 0
                                        ? "bg-warning text-dark"
                                        : deposit.status == 1
                                        ? "bg-success"
                                        : "bg-danger"
                                    }`}
                                  >
                                    {deposit.status == 0
                                      ? "Pending"
                                      : deposit.status == 1
                                      ? "Approve"
                                      : "Rejected"}
                                  </span>
                                </p>
                              </li>
                            ))}
                          </ul>
                          <table className="table table-striped table-dark pc_view">
                            <thead>
                              <tr>
                                <th>Trx id</th>
                                <th className="text-center">Date</th>
                                <th className="text-center">Amount</th>
                                <th className="text-center">Status</th>
                                <th className="text-center">Type</th>
                                <th className="text-center">Action</th>
                              </tr>
                            </thead>
                            <tbody>
                              {/* depositData */}

                              {depositData.map((deposit) => (
                                <tr key={deposit.id}>
                                  <td>{deposit.depositID}</td>
                                  <td className="text-center">
                                    {deposit.deposit_date}
                                  </td>
                                  <td className="text-center">
                                    ${deposit.deposit_amount}
                                  </td>
                                  <td className="text-center">
                                    <span
                                      className={`badge ${
                                        deposit.status == 0
                                          ? "bg-warning text-dark"
                                          : deposit.status == 1
                                          ? "bg-success"
                                          : "bg-danger"
                                      }`}
                                    >
                                      {deposit.status == 0
                                        ? "Pending"
                                        : deposit.status == 1
                                        ? "Approve"
                                        : "Rejected"}
                                    </span>
                                  </td>
                                  <td className="text-center">
                                    {deposit.payment_method}
                                  </td>
                                  <td>
                                    <center>
                                      <button
                                        className="btn_primary text-center"
                                        type="button"
                                        data-bs-toggle="modal"
                                        data-bs-target="#paymentModal"
                                        onClick={() =>
                                          getMoneyReceipt(deposit.id)
                                        }
                                      >
                                        Details
                                      </button>
                                    </center>
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
                  <div class="table-responsive">
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

                            {/* <tr>
                          <td>
                            <strong>Country ID</strong>
                          </td>
                          <td>18</td>
                        </tr> */}
                            {/* <tr>
                          <td>
                            <strong>Country Wise Bank ID</strong>
                          </td>
                          <td>5</td>
                        </tr> */}
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
