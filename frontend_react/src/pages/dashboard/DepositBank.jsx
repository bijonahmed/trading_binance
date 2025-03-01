import React, { useState, useRef, useEffect } from "react";
import { Helmet } from "react-helmet";
import Sidebar from "../../components/SidebarAuth";
import AuthGuard from "../../components/AuthGuard";
import NavbarAuth from "../../components/NavbarAuth";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import QRCode from "qrcode";
import { useParams } from "react-router-dom";
import AuthUser from "../../components/AuthUser";
import Loader from "../../components/Loader";

const DepositBankjsx = () => {
  const { bankId, countryId } = useParams();
  const [success, setCopySuccess] = useState(true);
  const { token, logout } = AuthUser();
  const intervalRef = useRef(null); // Reference to the interval
  const [waAddress, setAddress] = useState("");

  const { user } = AuthUser();
  const [loading, setLoading] = useState(true);
  const [particularInfo, setParticalarInfo] = useState("");
  const navigate = useNavigate();
  const [image, setImage] = useState(null);
  const [imagePreview, setImagePreview] = useState(null);
  const [amount, setAmount] = useState(""); // State to store input value
  const [errors, setErrors] = useState({});
  const [showconvertAmt, setconvertValue] = useState("");
  const [deposit_amount, setconvertusdtValue] = useState("0.00");

  const [file, setFile] = useState(null);
  const [preview, setPreview] = useState(null);

  // Handle file change and preview
  const handleFileChange = (e) => {
    const selectedFile = e.target.files[0];
    if (selectedFile) {
      setFile(selectedFile);
      setPreview(URL.createObjectURL(selectedFile)); // Create a preview for images
    }
  };

  const handleChangeDivisionCurrency = (e) => {
    const inputValue = e.target.value;
    if (/^\d*\.?\d*$/.test(inputValue)) {
      setconvertValue(inputValue.toString());
      const usdtAmount = particularInfo.usdt_rate
        ? (parseFloat(inputValue) / particularInfo.usdt_rate).toFixed(2)
        : "";
      console.log("USDT AMOUNT: " + usdtAmount);
      setconvertusdtValue(usdtAmount);
    }
  };

  const showCountryWiseBank = async () => {
    try {
      setLoading(true);
      const response = await axios.get(`/setting/getSelectedBank`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        params: {
          countryWiseBankId: bankId,
          countryId: countryId,
        },
      });
      // console.log("Response:", response.data.data);
      setParticalarInfo(response.data.data);
    } catch (error) {
      console.error("Error Data:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (event) => {
    event.preventDefault(); // Prevent default form submission
    setLoading(true);
    setErrors({}); // Reset errors before submitting

    try {
      if (!file) {
        console.log("Please upload an image before confirming.");
        setErrors({ image: "Please upload an image before confirming." });
        setLoading(false);
        return;
      }
      // Prepare form data
      const formData = new FormData();
      formData.append("file", file);
      formData.append("currencySymbol", particularInfo.currencySymbol);
      formData.append("deposit_amount", deposit_amount);
      formData.append("bank_name", particularInfo.bank_name);
      formData.append("bank_name", particularInfo.bank_name);
      formData.append("account_name", particularInfo.account_name);
      formData.append("account_number", particularInfo.account_number);
      formData.append("ific_code", particularInfo.ific_code);
      formData.append("swift_code", particularInfo.swift_code);
      formData.append("others_code", particularInfo.others_code);
      formData.append("inputAmount", particularInfo.showconvertAmt);
      formData.append("country_wise_bank_id", bankId);
      formData.append("countryId", countryId);
      formData.append("inputAmount", showconvertAmt);
     // Send request
      const response = await axios.post(
        `/deposit/sendDepositRequestToBank`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );
      console.log("Live request response:", response.data);
      $.notify("Deposit request submitted successfully!", "success");

      setTimeout(() => navigate("/dashboard/deposit"), 2000);
    } catch (error) {
      console.error("Registration error:", error);

      if (error.response) {
        console.error("Error response data:", error.response.data);
        if (error.response.data.errors) {
          setErrors(error.response.data.errors); // Set errors from API response
        } else {
          // toast.error(error.response.data.message || "Something went wrong!");
          $.notify(
            error.response.data.message || "Something went wrong!",
            "error"
          );
        }
      } else {
        // toast.error("Network error. Please try again.");
        $.notify("Network error. Please try again.", "error");
      }
    } finally {
      setLoading(false);
    }
  };

  const handleCopy = async (text) => {
    setLoading(true); // Start the loader
    try {
      await navigator.clipboard.writeText(text); // Attempt to copy the text
      setCopySuccess(true); // Indicate success
      $.notify("Copy", "success");
      setTimeout(() => setCopySuccess(false), 10000); // Reset success message after 10 seconds
    } catch (err) {
      console.error("Error copying text:", err); // Log the error
    } finally {
      setLoading(false); // Stop the loader
    }
  };

  useEffect(() => {
    showCountryWiseBank();
  }, [user, navigate]);

  
  return (
    <>
      <Helmet>
        <title>Deposit to Bank</title>
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
                <div className="page_title">
                  <a
                    href="#"
                    className="btn_back"
                    onClick={(e) => {
                      e.preventDefault(); // Prevents the default anchor behavior
                      window.history.back(); // Goes back to the previous page
                    }}
                  >
                    <i className="fa-solid fa-arrow-left" />
                  </a>
                  <div className="d-flex justify-content-between w-100 align-items-end">
                    <h4>Deposit to Bank</h4>
                  </div>
                </div>
                <div className="row">
                  <div className="col-md-6 m-auto">
                    <div className="qr_box">
                      <img
                        src="/fasttrading/images/Bank_image.png"
                        className="img-fluid"
                      />
                    </div>
                    <div className="box_text">
                      <p>
                        Send only USD to this account. This account does not
                        support deposit of other currency.
                      </p>
                    </div>
                    <div className="deposite_form">
                      <form onSubmit={handleSubmit}>
                        <div>
                          <div>
                            <h3>
                              Currency&nbsp;: {particularInfo.currencySymbol}
                            </h3>
                            <h3>
                              {" "}
                              Deposite Amount&nbsp;
                              <span style={{ color: "var(--color_primary)" }}>
                                (USD = {deposit_amount})
                              </span>
                            </h3>
                            <input
                              type="text"
                              className="form-control"
                              placeholder="00.00"
                              value={showconvertAmt}
                              onChange={handleChangeDivisionCurrency}
                            />
                          </div>
                        </div>
                        <div className="d-flex justify-content-between align-items-end">
                          <div>
                            <h3>Bank Name </h3>
                            <h2>{particularInfo.bank_name}</h2>
                          </div>
                          <div>
                            <button
                              type="button"
                              className="btn_edit"
                              onClick={() =>
                                handleCopy(particularInfo.bank_name)
                              }
                            >
                              <i className="fa-solid fa-copy" />
                            </button>
                          </div>
                        </div>
                        <div className="d-flex justify-content-between align-items-end">
                          <div>
                            <h3>Account Name </h3>
                            <h2>{particularInfo.account_name}</h2>
                          </div>
                          <div>
                            <button
                              type="button"
                              className="btn_edit"
                              onClick={() =>
                                handleCopy(particularInfo.account_name)
                              }
                            >
                              <i className="fa-solid fa-copy" />
                            </button>
                          </div>
                        </div>
                        <div className="d-flex justify-content-between align-items-end">
                          <div>
                            <h3>Account Num </h3>
                            <h2>{particularInfo.account_number}</h2>
                          </div>
                          <div>
                            <button
                              type="button"
                              className="btn_edit"
                              onClick={() =>
                                handleCopy(particularInfo.account_number)
                              }
                            >
                              <i className="fa-solid fa-copy" />
                            </button>
                          </div>
                        </div>

                        {particularInfo.ific_code && (
                          <>
                            <div className="d-flex justify-content-between align-items-end">
                              <div>
                                <h3>IFIC Code </h3>
                                <h2>{particularInfo.ific_code}</h2>
                              </div>
                              <div>
                                <button
                                  type="button"
                                  className="btn_edit"
                                  onClick={() =>
                                    handleCopy(particularInfo.ific_code)
                                  }
                                >
                                  <i className="fa-solid fa-copy" />
                                </button>
                              </div>
                            </div>
                          </>
                        )}

                        {particularInfo.swift_code && (
                          <>
                            <div className="d-flex justify-content-between align-items-end">
                              <div>
                                <h3>SWIFT Code </h3>
                                <h2>{particularInfo.swift_code}</h2>
                              </div>
                              <div>
                                <button
                                  type="button"
                                  className="btn_edit"
                                  onClick={() =>
                                    handleCopy(particularInfo.swift_code)
                                  }
                                >
                                  <i className="fa-solid fa-copy" />
                                </button>
                              </div>
                            </div>
                          </>
                        )}

                        {particularInfo.others_code && (
                          <>
                            <div className="d-flex justify-content-between align-items-end">
                              <div>
                                <h3>OTHERS Code </h3>
                                <h2>{particularInfo.others_code}</h2>
                              </div>
                              <div>
                                <button
                                  type="button"
                                  className="btn_edit"
                                  onClick={() =>
                                    handleCopy(particularInfo.others_code)
                                  }
                                >
                                  <i className="fa-solid fa-copy" />
                                </button>
                              </div>
                            </div>
                          </>
                        )}

                        <div className="mb-2">
                          <h3 className="text-danger">
                            Please Upload Your Deposite ScreenShort Here
                          </h3>
                          <input
                            type="file"
                            className="form-control"
                            onChange={handleFileChange}
                          />

                          {preview && (
                            <div className="mb-2" style={{ marginTop: "20px" }}>
                              <center>
                                <img
                                  src={preview}
                                  alt="Preview"
                                  style={{ maxWidth: "50%", height: "50%" }}
                                />
                              </center>
                            </div>
                          )}
                        </div>
                        <div className="mb-2" style={{ marginTop: "20px" }}>
                          <button
                            className="form-control btn_primary"
                            type="submit"
                          >
                            Confirm
                          </button>
                        </div>
                      </form>
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

export default DepositBankjsx;
