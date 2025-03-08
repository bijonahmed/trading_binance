import React, { useState, useRef, useEffect } from "react";
import { Helmet } from "react-helmet";

import Sidebar from "../../components/SidebarAuth";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import QRCode from "qrcode";
import { useParams } from "react-router-dom";
import AuthGuard from "../../components/AuthGuard";
import AuthUser from "../../components/AuthUser";
import Loader from "../../components/Loader";

const Payment = () => {
  const [hasRequested, setHasRequested] = useState(false);
  const { token, logout } = AuthUser();
  const [walletAddress, setWalletAddress] = useState("");
  const [currency, setCurrency] = useState("");
  const [mobileBanking, setMobileBanking] = useState("");
  const [mobileaccountNumber, setMobileAccNumber] = useState("");
  const [loading, setLoading] = useState(false);
  const [walletList, setWalletList] = useState([]);
  const [errors, setErrors] = useState({});
  const modalRef = useRef(null); // Reference for the modal

  const handleCurrencyChange = (event) => {
    setCurrency(event.target.value); // Set the selected currency
  };

  const handleMobileBankingChange = (event) => {
    setMobileBanking(event.target.value); // Set the selected currency
  };

  const handleMobileAccountChange = (event) => {
    setMobileAccNumber(event.target.value); // Set the selected currency
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

  const handleSubmitMobileBanking = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const formData = new FormData();
      formData.append("mobileBanking", mobileBanking);
      formData.append("mobileaccountNumber", mobileaccountNumber);

      const response = await axios.post(
        `/payment/sendPaymentMethodRequestMobileBanking`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );

      console.log("Live request response:", response.data);
      $.notify("Wallet Address successfully created!", "success");
      getWalletData();
      // Hide the Bootstrap Modal
      if (modalRef.current) {
        const modal = bootstrap.Modal.getInstance(modalRef.current);
        modal.hide();
      }
      // Clear form fields
      setWalletAddress("");
      setErrors({});
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

  const handleSubmitUsdt = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const formData = new FormData();
      formData.append("walletAddress", walletAddress);
      formData.append("currency", currency);

      const response = await axios.post(
        `/payment/sendPaymentMethodRequestUsdt`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );

      console.log("Live request response:", response.data);
      $.notify("Wallet Address successfully created!", "success");
      getWalletData();
      // Hide the Bootstrap Modal
      if (modalRef.current) {
        const modal = bootstrap.Modal.getInstance(modalRef.current);
        modal.hide();
      }
      // Clear form fields
      setWalletAddress("");
      setErrors({});
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
    getWalletData();
  }, []);

  return (
    <>
      <style>
        {`
        .st_filter select option {
            background-color: var(--color_primary);
            background-color: var(--color_secondary);
        }

        .st_filter select option:hover,
        .st_filter select option:focus,
        .st_filter select option::selection {
            background-color: var(--color_primary) !important;
            color: var(--color_secondary);
        }

        .st_filter .nav-tabs .nav-link {
            border-radius: 10px;
            border: none;
            color: #fff;
        }

        .st_filter .nav-tabs .nav-item.show .nav-link,
        .st_filter .nav-tabs .nav-link.active {
            background-color: var(--color_primary) !important;
            color: var(--color_secondary);
        }

        .nav.nav-tabs {
            border: none;
            margin-bottom: 15px;
        }
      `}
      </style>

      <Helmet>
        <title>Payment Method</title>
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
                      <h4>Payment Method</h4>
                      <button
                        className="btn_primary"
                        data-bs-toggle="modal"
                        data-bs-target="#paymentModal"
                      >
                        <i className="fa-solid fa-plus" />
                        Add new
                      </button>
                    </div>
                  </div>
                  <div className="s_content">
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
                    <div id="card-list">
                      {/* walletList */}
                      {walletList.map((wallet, index) => (
                        <div
                          className="bank_card z-3 scaled"
                          key={index}
                          style={{ zIndex: 3 }}
                        >
                          <div className="carde">
                            <div className="card-inner">
                              <div className="front">
                                {wallet.type == "crypto" && (
                                  <>
                                    <img
                                      src="/fasttrading/images/Card.png"
                                      className="map-img"
                                    />
                                  </>
                                )}

                                {wallet.type == "mobile_banking" && (
                                  <>
                                    <img
                                      src="/fasttrading/images/mobile_banking.png"
                                      className="map-img"
                                    />
                                  </>
                                )}

                                <div className="rows card-no">
                                  {wallet.type == "crypto" && (
                                    <>
                                      <p className="d-flex align-items-center">
                                        {wallet.wallet_address}
                                      </p>
                                    </>
                                  )}

                                  {wallet.type == "mobile_banking" && (
                                    <>
                                      <p
                                        className="d-flex align-items-center"
                                        style={{ color: "white" }}
                                      >
                                        {wallet.mobileBanking}
                                        <br />
                                        {wallet.mobileaccountNumber}
                                      </p>
                                    </>
                                  )}
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* add new modal start here  */}
          <div
            className="modal fade"
            id="paymentModal"
            tabIndex={-1}
            aria-labelledby="boostModalLabel"
            aria-modal="true"
            role="dialog"
            ref={modalRef}
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
                  <div className="form_group">
                    {/* Crypto tab  */}
                    <div className="st_filter">
                      <ul className="nav nav-tabs" id="myTab" role="tablist">
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link active"
                            id="home-tab"
                            data-bs-toggle="tab"
                            data-bs-target="#home-tab-pane"
                            type="button"
                            role="tab"
                            aria-controls="home-tab-pane"
                            aria-selected="true"
                          >
                            Crypto
                          </button>
                        </li>
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link"
                            id="profile-tab"
                            data-bs-toggle="tab"
                            data-bs-target="#profile-tab-pane"
                            type="button"
                            role="tab"
                            aria-controls="profile-tab-pane"
                            aria-selected="false"
                          >
                            Mobile Banking
                          </button>
                        </li>
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link"
                            id="contact-tab"
                            data-bs-toggle="tab"
                            data-bs-target="#contact-tab-pane"
                            type="button"
                            role="tab"
                            aria-controls="contact-tab-pane"
                            aria-selected="false"
                          >
                            Bank
                          </button>
                        </li>
                      </ul>
                      <div className="tab-content" id="myTabContent">
                        <div
                          className="tab-pane fade show active"
                          id="home-tab-pane"
                          role="tabpanel"
                          aria-labelledby="home-tab"
                          tabindex="0"
                        >
                          <form
                            onSubmit={handleSubmitUsdt}
                            className="withdraw_form"
                          >
                            <div className="form_group">
                              <p>
                                Currency type
                                <span className="text-danger d-inline">*</span>
                              </p>
                              <select
                                id="mySelect2"
                                className="form-control"
                                value={currency}
                                onChange={handleCurrencyChange}
                              >
                                   <option value="">Select</option>
                                <option>USDT-TRC20-TRX</option>
                                <option>USDC-TRC20-TRX</option>
                              </select>
                            </div>
                            <div id="additionalFields2" style={{}}>
                              <div className="form_group mb-2">
                                <p>
                                  Wallet Address
                                  <span className="text-danger d-inline">
                                    *
                                  </span>{" "}
                                </p>
                                <input
                                  type="text"
                                  placeholder="Address"
                                  className="form-control mb-0"
                                  value={walletAddress}
                                  onChange={(e) =>
                                    setWalletAddress(e.target.value)
                                  }
                                />
                                {errors.walletAddress && (
                                  <div className="error text-danger">
                                    {errors.walletAddress}
                                  </div>
                                )}
                              </div>
                            </div>
                            <button
                              type="submit"
                              className="btn_action w-100 mt-2"
                            >
                              Save
                            </button>
                          </form>
                        </div>
                        <div
                          className="tab-pane fade"
                          id="profile-tab-pane"
                          role="tabpanel"
                          aria-labelledby="profile-tab"
                          tabindex="0"
                        >
                          <form
                            className="withdraw_form"
                            onSubmit={handleSubmitMobileBanking}
                          >
                            <div class="form_group">
                              <p>
                                Select Mobile Banking
                                <span className="text-danger d-inline">*</span>
                              </p>
                              <select
                                name=""
                                id="mySelect2"
                                className="form-control"
                                value={mobileBanking}
                                onChange={handleMobileBankingChange}
                              >
                                <option value="">Select</option>
                                <option>Bkash</option>
                                <option>Nogot</option>
                                <option>Rocket</option>
                                <option>Upay</option>
                              </select>

                              {errors.mobileBanking && (
                                <div className="error text-danger">
                                  {errors.mobileBanking}
                                </div>
                              )}
                            </div>
                            <div>
                              <div className="form_group mb-2">
                                <p>
                                  Account Number
                                  <span className="text-danger d-inline">
                                    *
                                  </span>
                                </p>
                                <input
                                  type="text"
                                  placeholder="Account Number"
                                  className="form-control mb-0"
                                  value={mobileaccountNumber}
                                  onChange={handleMobileAccountChange}
                                />
                                {errors.mobileaccountNumber && (
                                  <div className="error text-danger">
                                    {errors.mobileaccountNumber}
                                  </div>
                                )}
                              </div>
                            </div>

                            <button
                              type="submit"
                              className="btn_action w-100 mt-2"
                            >
                              Save
                            </button>
                          </form>
                        </div>
                        <div
                          className="tab-pane fade"
                          id="contact-tab-pane"
                          role="tabpanel"
                          aria-labelledby="contact-tab"
                          tabindex="0"
                        >
                          <form action="" className="withdraw_form">
                            <div className="form_group">
                              <p>
                                Select Bank
                                <span className="text-danger d-inline">*</span>
                              </p>
                              <select id="mySelect2" className="form-control">
                                <option selected="" value="">
                                  City Bank PLC
                                </option>
                                <option selected="" value="">
                                  Sonali Bank PLC
                                </option>
                                <option selected="" value="">
                                  Trust Bank PLC
                                </option>
                                <option selected="" value="">
                                  Datch Bangla Bank PLC
                                </option>
                                <option selected="" value="">
                                  Islami Bank PLC
                                </option>
                              </select>
                            </div>
                            <div>
                              <div className="form_group mb-2">
                                <p>
                                  Account Number
                                  <span className="text-danger d-inline">
                                    *
                                  </span>
                                </p>
                                <input
                                  type="text"
                                  placeholder="Account Number"
                                  className="form-control mb-0"
                                />
                              </div>
                            </div>

                            <button
                              type="submit"
                              className="btn_action w-100 mt-2"
                            >
                              Save
                            </button>
                          </form>
                        </div>
                      </div>
                      {/* ====================================== */}
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

export default Payment;
