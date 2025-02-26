import React, { useState } from "react";
import { Helmet } from "react-helmet";
import Sidebar from "../../components/SidebarAuth";
import AuthGuard from "../../components/AuthGuard";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import QRCode from "qrcode";
import { useParams } from "react-router-dom";

const Deposit = () => {
  const [hasRequested, setHasRequested] = useState(false);
  // Data array containing deposit methods
  const depositOptions = [
    { slug: "btc", name: "BTC", imgSrc: "/fasttrading/images/btc.png" },
    { slug: "usdt", name: "USDT", imgSrc: "/fasttrading/images/usdt.png" },
    { slug: "eth", name: "Ethereum", imgSrc: "/fasttrading/images/eth.png" },
  ];
 

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
                  <a
                    href="#"
                    className="btn_back"
                    onClick={(e) => {
                      e.preventDefault();
                      window.history.back();
                    }}
                  >
                    <i className="fa-solid fa-arrow-left" />
                  </a>
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
                <div>
                  <div className="details_card">
                    <h4>Deposit to Card</h4>
                    <div className="deposit_method">
                      <div className="deposit_option">
                        <a href="#">
                          <img
                            src="/fasttrading/images/visa-card-100.png"
                            className="img-fluid"
                          />
                          <h4>VISA</h4>
                        </a>
                      </div>
                      <div className="deposit_option">
                        <a href="#">
                          <img
                            src="/fasttrading/images/mastercard-100.png"
                            className="img-fluid"
                          />
                          <h4>Mastercard</h4>
                        </a>
                      </div>
                    </div>
                  </div>
                  <div className="details_card d-none">
                    <h4>Deposit to Bank</h4>
                    <div className="row">
                      <div className="col-md-6 my-3">
                        <select className="form-control">
                          <option disabled>Select Country</option>
                          <option>USA</option>
                          <option>UK</option>
                          <option>UAE</option>
                          <option>Bangladesh</option>
                        </select>
                      </div>
                    </div>
                    <div className="deposit_method">
                      <div className="deposit_option">
                        <a href="deposit-bank.html">
                          <img
                            src="/fasttrading/images/Bank_image.png"
                            className="img-fluid"
                          />
                          <h4>ABC Bank</h4>
                        </a>
                      </div>
                      <div className="deposit_option">
                        <a href="deposit-bank.html">
                          <img
                            src="/fasttrading/images/Bank_image.png"
                            className="img-fluid"
                          />
                          <h4>ABC Bank</h4>
                        </a>
                      </div>
                      <div className="deposit_option">
                        <a href="deposit-bank.html">
                          <img
                            src="/fasttrading/images/Bank_image.png"
                            className="img-fluid"
                          />
                          <h4>ABC Bank</h4>
                        </a>
                      </div>
                      <div className="deposit_option">
                        <a href="deposit-bank.html">
                          <img
                            src="/fasttrading/images/Bank_image.png"
                            className="img-fluid"
                          />
                          <h4>ABC Bank</h4>
                        </a>
                      </div>
                      <div className="deposit_option">
                        <a href="deposit-bank.html">
                          <img
                            src="/fasttrading/images/Bank_image.png"
                            className="img-fluid"
                          />
                          <h4>ABC Bank</h4>
                        </a>
                      </div>
                      <div className="deposit_option">
                        <a href="deposit-bank.html">
                          <img
                            src="/fasttrading/images/Bank_image.png"
                            className="img-fluid"
                          />
                          <h4>ABC Bank</h4>
                        </a>
                      </div>
                      <div className="deposit_option">
                        <a href="deposit-bank.html">
                          <img
                            src="/fasttrading/images/Bank_image.png"
                            className="img-fluid"
                          />
                          <h4>ABC Bank</h4>
                        </a>
                      </div>
                      <div className="deposit_option">
                        <a href="deposit-bank.html">
                          <img
                            src="/fasttrading/images/Bank_image.png"
                            className="img-fluid"
                          />
                          <h4>ABC Bank</h4>
                        </a>
                      </div>
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
