import React, { useState, useEffect, navigate } from "react";
import { Helmet } from "react-helmet";
import Sidebar from "../../components/SidebarAuth";
import AuthGuard from "../../components/AuthGuard";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import QRCode from "qrcode";
import { useParams } from "react-router-dom";
import AuthUser from "../../components/AuthUser";
import Loader from "../../components/Loader";
import { useNavigate } from "react-router-dom";

const Deposit = () => {
  const navigate = useNavigate(); // Get the navigate function
  const [hasRequested, setHasRequested] = useState(false);
  const [allCountry, setCountryName] = useState([]);
  const { token, logout } = AuthUser();
  const [selectedCountry, setSelectedCountry] = useState("");
  const [bankList, setBankList] = useState([]);
  const [loading, setLoading] = useState(false);

  const showAllBankCountryWise = async (event) => {
    const country_id = event.target.value;
    setSelectedCountry(event.target.value);
    try {
      setLoading(true);
      const response = await axios.get(`/setting/getAllBankList`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
        params: {
          country_id: country_id, // First parameter
        },
      });
      // console.log("Response:", response.data.data);
      setBankList(response.data.data);
    } catch (error) {
      console.error("Error Data:", error);
    } finally {
      setLoading(false);
    }
  };

  const getAddCountry = async () => {
    try {
      const response = await axios.get(`/setting/getCountryGroupList`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        }, // Removed the extra comma here
      });
      setCountryName(response.data.data);
    } catch (error) {
      console.error("Error Data:", error);
    }
  };

  useEffect(() => {
    getAddCountry();
  }, []);

  // Data array containing deposit methods
  const depositOptions = [
    { slug: "btc", name: "BTC", imgSrc: "/fasttrading/images/btc.png" },
    { slug: "usdt", name: "USDT", imgSrc: "/fasttrading/images/usdt.png" },
    { slug: "eth", name: "Ethereum", imgSrc: "/fasttrading/images/eth.png" },
  ];
  const goBack = () => {
    console.log("/dashboard/wallet");
    history.push("/dashboard/wallet");
  };

  return (
    <>
      <Helmet>
        <title>Deposit</title>
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
                  <Link className="btn_back" to="/dashboard/wallet">
                    <i className="fa-solid fa-arrow-left" />
                  </Link>
                  <div className="d-flex justify-content-between w-100 align-items-end">
                    <h4>Deposit</h4>
                  </div>
                </div>
                <div className="details_card">
                  <h4>Crypto</h4>

                  <div className="deposit_method">
                    {depositOptions.map((option) => (
                      <div className="deposit_option" key={option.slug}>
                        <Link to={`/deposit-crypto/${option.slug}`}>
                          <img
                            src={option.imgSrc}
                            className="img-fluid"
                            alt={option.name}
                          />
                          <h4>{option.name}</h4>
                        </Link>
                      </div>
                    ))}
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
                <div>
                  <div className="details_card">
                    <h4>Deposit to Bank</h4>
                    <div className="row">
                      <div className="col-md-6 my-3">
                        <select
                          value={selectedCountry}
                          onChange={showAllBankCountryWise}
                          className="form-control"
                        >
                          <option value="">-- Select --</option>
                          {allCountry.map((country) => (
                            <option key={country.id} value={country.country_id}>
                              {country.country_name} [{country.currency_symbol}]
                            </option>
                          ))}
                        </select>
                      </div>
                    </div>
                    <div className="deposit_method">
                      {bankList.map((bank, index) => (
                        <div className="deposit_option" key={index}>
                          <Link
                            to={`/deposit-bank/${bank.id}/${bank.country_id}`}
                          >
                            <img
                              src="/fasttrading/images/Bank_image.png"
                              className="img-fluid"
                              alt={bank.bank_name}
                            />
                            <h4>{bank.bank_name}</h4>
                          </Link>
                        </div>
                      ))}
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

export default Deposit;
