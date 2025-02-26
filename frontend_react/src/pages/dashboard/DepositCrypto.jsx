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

const DepositCrypto = () => {
  const [success, setCopySuccess] = useState(true);
  const { token, logout } = AuthUser();
  const intervalRef = useRef(null); // Reference to the interval
  const [waAddress, setAddress] = useState("");
  const { slug } = useParams();
  const { user } = AuthUser();
  const [loading, setLoading] = useState(true);
  const [countdown, setCountdown] = useState("00:00"); // Initial countdown value
  const navigate = useNavigate();
  const [image, setImage] = useState(null);
  const [imagePreview, setImagePreview] = useState(null);
  const [amount, setAmount] = useState(""); // State to store input value
  const [errors, setErrors] = useState({});

  const handleFileChange = (event) => {
    const file = event.target.files[0];

    if (file && file.type.startsWith("image/")) {
      setImage(file);
      setImagePreview(URL.createObjectURL(file));
    } else {
      alert("Only images are allowed (JPG, PNG, JPEG).");
      event.target.value = "";
      setImage(null);
      setImagePreview(null);
    }
  };

  const startCountdown = (initialTimeLeft) => {
    let timeLeft = initialTimeLeft;
    if (timeLeft <= 0) return;

    intervalRef.current = setInterval(() => {
      timeLeft -= 1000;
      if (timeLeft <= 0) {
        clearInterval(intervalRef.current);
        setCountdown("0:00");
        window.location.href = "/dashboard/deposit"; // Redirect when countdown ends
      } else {
        const minutes = Math.floor(timeLeft / 60000);
        const seconds = Math.floor((timeLeft % 60000) / 1000);
        setCountdown(`${minutes}:${seconds < 10 ? "0" + seconds : seconds}`);
      }
    }, 1000);
  };
  const getDepositWalletAddress = async () => {
    console.log("Send Request.....");
    setLoading(true);
    try {
      const lastRequestData = JSON.parse(
        localStorage.getItem("lastRequestData")
      ) || {
        timestamp: 0,
        walletAddress: "",
      };
      const currentTimestamp = Date.now();
      const timeLeft = 1800000 - currentTimestamp;
      startCountdown(timeLeft);
      const response = await axios.post(
        "/payment/getWalletAddress",
        { token },
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
        }
      );

      const walletName = response.data.data;
      console.log("walletName:" + walletName);
      if (!walletName) throw new Error("Wallet name is missing.");
      const newRequestData = {
        walletAddress: walletName,
        timestamp: currentTimestamp,
      };
      localStorage.setItem("lastRequestData", JSON.stringify(newRequestData));

      setAddress(walletName);
      startCountdown(1800000);
      const canvas = document.getElementById("canvas");
      if (canvas) {
        QRCode.toCanvas(canvas, walletName, (error) => {
          if (error) console.error("Error generating QR code:", error);
        });
      }
    } catch (error) {
      console.error("Error:", error);
      alert(error.message);
    } finally {
      setLoading(false);
    }
  };

  const amounts = [50, 100, 300, 500, 1000]; // List of amounts

  // Function to update input with clicked amount
  const handleAmountClick = (value) => {
    setAmount(value.toString());
  };

  // Function to sum all amounts when clicking "All"
  const handleAllClick = () => {
    const total = amounts.reduce((acc, num) => acc + num, 0);
    setAmount(total.toString());
  };

  const handleSubmit = async (event) => {
    event.preventDefault(); // Prevent default form submission
    setLoading(true);
    setErrors({}); // Reset errors before submitting

    try {
      if (!image) {
        setErrors({ image: "Please upload an image before confirming." });
        setLoading(false);
        return;
      }

      // Prepare form data
      const formData = new FormData();
      formData.append("amount", amount);
      formData.append("image", image);
      formData.append("token", token);
      formData.append("waAddress", waAddress);
      formData.append("cryptoType", slug?.toUpperCase());

      // Send request
      const response = await axios.post(
        `/deposit/sendDepositRequestToCrypto`,
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

  const handleCopy = async () => {
    setLoading(true); // Start the loader
    try {
      await navigator.clipboard.writeText(waAddress); // Attempt to copy the text
      setCopySuccess(true); // Indicate success
      $.notify("Copy", "success");
      setTimeout(() => setCopySuccess(false), 10000); // Reset success message after 2 seconds
    } catch (err) {
      console.error("Error copying text:", err); // Log the error
    } finally {
      setLoading(false); // Stop the loader
    }
  };


  const handletrc20Copy = async () => {
    setLoading(true); // Start the loader
    try {
      await navigator.clipboard.writeText("Tron (TRC 20)"); // Attempt to copy the text
      setCopySuccess(true); // Indicate success
      $.notify("Copy", "success");
      setTimeout(() => setCopySuccess(false), 10000); // Reset success message after 2 seconds
    } catch (err) {
      console.error("Error copying text:", err); // Log the error
    } finally {
      setLoading(false); // Stop the loader
    }
  };

  useEffect(() => {
    getDepositWalletAddress();
    return () => clearInterval(intervalRef.current);
  }, [user, waAddress, navigate]);

  return (
    <>
      <Helmet>
        <title>Deposit Crypto [{slug?.toUpperCase()}]</title>
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
                  <Link to="/dashboard/deposit" className="btn_back">
                    <i className="fa-solid fa-arrow-left" />
                  </Link>
                  <div className="d-flex justify-content-between w-100 align-items-end">
                    <h4>Deposit to Crypto</h4>
                  </div>
                </div>
                <div className="row">
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
                  <div className="col-md-6 m-auto">
                    <div
                      style={{
                        textAlign: "center",
                        fontSize: "30px",
                        fontWeight: "bold",
                        color: "red",
                      }}
                    >
                      {countdown}
                    </div>
                    <div className="qr_box">
                      <canvas id="canvas"></canvas>
                    </div>

                    <div className="box_text">
                      <p>
                        Send only USDT to this deposit address. This address
                        does not support deposit of non-fungible token, please
                        go to NFT page to deposit NFT.
                      </p>
                    </div>
                    <div className="deposite_form">
                      <form onSubmit={handleSubmit}>
                        <div>
                          <div>
                            <h3>Deposit Amount</h3>
                            <input
                              type="text"
                              className="form-control"
                              placeholder="00.00"
                              value={amount}
                              readOnly // Prevent manual input
                            />

                            {errors.amount && (
                              <div className="error text-danger">
                                {errors.amount}
                              </div>
                            )}

                            <div className="row mt-2">
                              {amounts.map((num, index) => (
                                <div key={index} className="col-2">
                                  <button
                                    type="button"
                                    className="btn btn_ammount"
                                    onClick={() => handleAmountClick(num)}
                                  >
                                    {num}
                                  </button>
                                </div>
                              ))}
                              <div className="col-2">
                                <button
                                  className="btn btn_ammount"
                                  type="button"
                                  onClick={handleAllClick}
                                >
                                  All
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div className="d-flex justify-content-between align-items-end">
                          <div>
                            <h3>Wallet Address</h3>
                            <h2>{waAddress}</h2>
                          </div>
                          <div>
                            <button
                              type="button"
                              className="btn_edit"
                              onClick={handleCopy}
                            >
                              <i className="fa-solid fa-copy" />
                            </button>
                          </div>
                        </div>
                        <div className="d-flex justify-content-between align-items-end">
                          <div>
                            <h3>Network Address</h3>
                            <h2>Tron (TRC 20)</h2>
                          </div>
                          <div>
                            <button type="button" className="btn_edit" onClick={handletrc20Copy}>
                              <i className="fa-solid fa-copy " />
                            </button>
                          </div>
                        </div>
                        <div className="form_information">
                          <div className="d-flex justify-content-between align-items-center my-2">
                            <div>
                              <h4>Minimum deposit</h4>
                            </div>
                            <div>
                              <p>50.00 USDT</p>
                            </div>
                          </div>
                          <div className="d-flex justify-content-between align-items-center my-2">
                            <div>
                              <h4>Maximum deposit</h4>
                            </div>
                            <div>
                              <p>1950 USDT</p>
                            </div>
                          </div>
                          <div className="d-flex justify-content-between align-items-center my-2">
                            <div>
                              <h4>Expected arrival</h4>
                            </div>
                            <div>
                              <p>1 network confirmation</p>
                            </div>
                          </div>
                          <div className="d-flex justify-content-between align-items-center my-2">
                            <div>
                              <h4>Expected unlock</h4>
                            </div>
                            <div>
                              <p>1 network confirmations</p>
                            </div>
                          </div>
                        </div>
                        <div className="mb-2">
                        <h3 className="text-danger">Please Upload Your Deposit Screenshot Here</h3>
                          <input
                            type="file"
                            className="form-control"
                            accept="image/*"
                            onChange={handleFileChange}
                          />
                          {imagePreview && (
                            <img
                              src={imagePreview}
                              alt="Preview"
                              className="mt-2 img-fluid"
                              style={{ maxWidth: "100px", borderRadius: "5px" }}
                            />
                          )}
                          {errors.image && (
                              <div className="error text-danger">
                                {errors.image}
                              </div>
                            )}

                        </div>
                        <div className="mb-2">
                          <button
                            type="submit"
                            className="form-control btn_primary"
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

export default DepositCrypto;
