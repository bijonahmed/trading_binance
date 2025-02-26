import React, { useState, useRef, useEffect } from "react";
import { Helmet } from "react-helmet";
import Sidebar from "../../components/SidebarAuth";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import QRCode from "qrcode";
import { useNavigate } from "react-router-dom";
import { useParams } from "react-router-dom";
import AuthGuard from "../../components/AuthGuard";
import AuthUser from "../../components/AuthUser";
import Loader from "../../components/Loader";
import "../../components/css/Withdrawal.css"; // Import your CSS file

const Withdraw = () => {
  const [hasRequested, setHasRequested] = useState(false);
  const { token, logout } = AuthUser();
  const [currentBalance, setCurrentBalance] = useState("");
  const [withdrawal_amount, setwithdrawalAmount] = useState("");
  const [loading, setLoading] = useState(false);
  const [verfiyStatus, setverficationStatus] = useState("");
  const [walletList, setWalletList] = useState([]);
  const [selectedWallet, setSelectedWallet] = useState("");
  const [errors, setErrors] = useState({});
  const [showModal, setShowModal] = useState(false);
  const navigate = useNavigate();
  const backtolist = async () => {
    navigate("/dashboard/kyc");
    window.location.reload(); // Reloads the page after redirection
  };
  

  const checkingKyc = async () => {
    try {
      const response = await axios.get(`/user/checkkyc`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        }, // Removed the extra comma here
      });
      const verfication_status = response.data.verfication_status;
      setverficationStatus(verfication_status);
    } catch (error) {
      console.error("Error Data:", error);
    }
  };

  const getWalletData = async () => {
    try {
      setLoading(true);
      const response = await axios.get(`/payment/walltAddressList`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        }, // Removed the extra comma here
      });
      const historyData = response.data.data;
      setWalletList(historyData);
    } catch (error) {
      console.error("Error Data:", error);
    } finally {
      setLoading(false);
    }
  };

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
    setLoading(true);

    try {
      const formData = new FormData();
      formData.append("withdrawal_amount", withdrawal_amount);
      formData.append("wallet_address", selectedWallet);

      const response = await axios.post(
        `/withdrawal/sendWithdrawalRequest`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );

      console.log("Live request response:", response.data);
      $.notify("Withdrawal request has been successfully send", "success");
      getWalletData();
      getCurrentBalance();
      // Hide the Bootstrap Modal
      // Clear form fields
    } catch (error) {
      console.error("Registration error:", error);

      if (error.response) {
        console.error("Error response data:", error.response.data);
        if (error.response.data.errors) {
          setErrors(error.response.data.errors); // Set errors from API response
        } else {
          $.notify(
            error.response.data.message || "Something went wrong!",
            "error"
          );
        }
      } else {
        $.notify("Network error. Please try again.", "error");
      }
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    checkingKyc();
    getWalletData();
    getCurrentBalance();
  }, []);

  useEffect(() => {
    if (verfiyStatus === 0) {
      const modal = new window.bootstrap.Modal(
        document.getElementById("kycModal")
      );
      modal.show(); // Show the Bootstrap modal when verifyStatus is 0
    }
  }, [verfiyStatus]); // ✅ Runs when verifyStatus changes
  return (
    <>
      <Helmet>
        <title>Withdraw</title>
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

          {/* Dashbaord Content Start */}

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
                      <h4>Withdraw</h4>
                    </div>
                  </div>
                </div>
                {/* withdraw form  */}
                <div className="row">
                  <div className="col-md-6 m-auto">
                    <form
                      onSubmit={handleSubmit}
                      className="withdrawal_form but_token_form"
                    >
                      <p className="badge_">
                        <i className="fa-solid fa-circle-exclamation" /> &nbsp;
                        Minimum withdraw 20 USDT
                      </p>
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
                      <div className="form_group">
                        <p>Withdrawal Amount (Max-withdraw: 3690.00 USDT)</p>
                        <div className="input_group">
                          <input
                            type="text"
                            className="form-control"
                            placeholder="00.00"
                            value={withdrawal_amount}
                            onChange={(e) =>
                              setwithdrawalAmount(e.target.value)
                            }
                            onInput={(e) => {
                              e.target.value = e.target.value
                                .replace(/[^0-9.]/g, "") // Remove non-numeric and non-dot characters
                                .replace(/^0+(\d)/, "$1") // Remove leading zeros (optional)
                                .replace(/(\..*)\./g, "$1"); // Prevent multiple dots
                            }}
                          />

                          {errors.withdrawal_amount && (
                            <div className="error text-danger">
                              {errors.withdrawal_amount}
                            </div>
                          )}
                        </div>
                        <span>Current amount : {currentBalance} USDT</span>
                      </div>
                      <div className="form_group">
                        <p>Withdrawal address</p>
                        <div className="input_group">
                          <select
                            className="form-control rounded-0 mb-0"
                            onChange={(e) => setSelectedWallet(e.target.value)}
                          >
                            <option>Select</option>
                            {walletList.map((wallet, index) => (
                              <option key={index} value={wallet.wallet_address}>
                                {wallet.wallet_address}
                              </option>
                            ))}
                          </select>
                          {errors.wallet_address && (
                            <div className="error text-danger">
                              {errors.wallet_address}
                            </div>
                          )}
                        </div>
                      </div>
                      {/* <div className="form_group">
                        <p>Please Enter Withdrawal Pin</p>
                        <div className="input_group">
                          <input type="text" className="form-control" />
                        </div>
                      </div> */}
                      <button type="submit" className="btn_primary w-100 mt-3">
                        Confirm Withdraw{" "}
                      </button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
            <div>
              {/* Your existing content */}

              {/* Bootstrap Modal */}
              <div
                className="modal fade"
                id="kycModal"
                tabIndex="-1"
                data-bs-backdrop="static" /* Prevents closing on outside click */
                data-bs-keyboard="false" /* Prevents closing with the keyboard (Esc key) */
                aria-labelledby="kycModalLabel"
                aria-hidden="true"
              >
                <div className="modal-dialog modal-dialog-centered">
                  <div className="modal-content custom-danger-modal">
                    <div className="modal-header">
                      <h5 className="modal-title" id="kycModalLabel">
                        Verification Required
                      </h5>
                      {/* <button
                        type="button"
                        className="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                      ></button> */}
                    </div>
                    <div className="modal-body text-white">
                      Your KYC is not verified. Please complete the verification
                      process.
                    </div>
                    <div className="modal-footer">
                      <button
                        onClick={backtolist}
                        type="button"
                        className="btn btn-secondary"
                      >
                        Back
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Dashboard Content End */}
        </div>
      </div>
    </>
  );
};

export default Withdraw;
