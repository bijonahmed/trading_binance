import React, { useState, useEffect, navigate } from "react";
import { Helmet } from "react-helmet";
import Sidebar from "../../components/SidebarAuth";
import AuthGuard from "../../components/AuthGuard";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import { useParams } from "react-router-dom";
import AuthUser from "../../components/AuthUser";
import { useNavigate } from "react-router-dom"; // Combine imports from react-router-dom

const MobileMenu = () => {
  const navigate = useNavigate();
  const { token, logout } = AuthUser();
  const logoutUser = async () => {
    logout();
    localStorage.removeItem("token");
    setTimeout(() => {
      navigate("/login");
    }, 100); // Small delay to allow state update
  };

  return (
    <>
      <Helmet>
        <title>Deposit</title>
      </Helmet>

      <div>
        {/* Sidebar Start */}
        <Sidebar />
        <NavbarAuth />
        <AuthGuard />

        {/* Sidebar End */}

        <div className="main_dashboard">
          <div className="dashboard_content">
            <div className="row">
              {/* Sidebar visible only on mobile */}
              <div className="d-lg-none">
                <nav className="nav_sidebar">
                  <ul className="sidebar_list">
                    <li
                      className={`sidebar_item ${
                        location.pathname === "/dashboard/profile"
                          ? "active"
                          : ""
                      }`}
                    >
                      <Link to="/dashboard/profile" className="sidebar_link">
                        <i className="fa-regular fa-user" />
                        <span>Profile</span>
                      </Link>
                    </li>
                    <li
                      className={`sidebar_item ${
                        location.pathname === "/market" ? "active" : ""
                      }`}
                    >
                      <Link to="/market" className="sidebar_link">
                        <i className="fa-solid fa-chart-line" />
                        <span>Market</span>
                      </Link>
                    </li>
                    <li
                      className={`sidebar_item ${
                        location.pathname === "/future" ? "active" : ""
                      }`}
                    >
                      <Link to="/future/btc" className="sidebar_link">
                        <i className="fa-solid fa-chart-candlestick" />
                        <span>Futures</span>
                      </Link>
                    </li>
                    <li
                      className={`sidebar_item ${
                        location.pathname === "/dashboard/wallet"
                          ? "active"
                          : ""
                      }`}
                    >
                      <Link to="/dashboard/wallet" className="sidebar_link">
                        <i className="fa-solid fa-wallet" />
                        <span>Wallet</span>
                      </Link>
                    </li>
                    <li
                      className={`sidebar_item ${
                        location.pathname === "/dashboard/deposit"
                          ? "active"
                          : ""
                      }`}
                    >
                      <Link to="/dashboard/deposit" className="sidebar_link">
                        <i className="fa-solid fa-download" />
                        <span>Deposit</span>
                      </Link>
                    </li>
                    <li
                      className={`sidebar_item ${
                        location.pathname === "/dashboard/withdraw"
                          ? "active"
                          : ""
                      }`}
                    >
                      <Link to="/dashboard/withdraw" className="sidebar_link">
                        <i className="fa-solid fa-upload" />
                        <span>Withdraw</span>
                      </Link>
                    </li>
                    <li
                      className={`sidebar_item ${
                        location.pathname === "/dashboard/payment"
                          ? "active"
                          : ""
                      }`}
                    >
                      <Link to="/dashboard/payment" className="sidebar_link">
                        <i className="fa-regular fa-credit-card" />
                        <span>Payment Method</span>
                      </Link>
                    </li>
                    <li
                      className={`sidebar_item ${
                        location.pathname === "/dashboard/trade-history"
                          ? "active"
                          : ""
                      }`}
                    >
                      <Link
                        to="/dashboard/trade-history"
                        className="sidebar_link"
                      >
                        <i className="fa-solid fa-money-bill-transfer" />
                        <span>Trade History</span>
                      </Link>
                    </li>
                    <li
                      className={`sidebar_item ${
                        location.pathname === "/dashboard/kyc" ? "active" : ""
                      }`}
                    >
                      <Link to="/dashboard/kyc" className="sidebar_link">
                        <i className="fa-light fa-address-card" />
                        <span>KYC Verification</span>
                      </Link>
                    </li>
                    <li className="sidebar_item" onClick={logoutUser}>
                      <Link to="#" className="sidebar_link">
                        <i className="fa-solid fa-right-from-bracket" />
                        <span>Logout</span>
                      </Link>
                    </li>
                  </ul>
                </nav>
              </div>
            </div>
          </div>
          {/* Dashboard Content End */}
        </div>
      </div>
    </>
  );
};

export default MobileMenu;
