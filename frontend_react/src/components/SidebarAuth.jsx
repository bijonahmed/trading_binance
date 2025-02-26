import React from "react";
import { Link, useNavigate,useLocation } from "react-router-dom";

import AuthUser from "./AuthUser";
import AuthGuard from "./AuthGuard";

const SidebarAuth = () => {
  const navigate = useNavigate();
  const { logout } = AuthUser();
  const location = useLocation(); // ✅ Get current path

  const logoutUser = async () => {
    logout();
    localStorage.removeItem("token");
    setTimeout(() => {
      navigate("/login");
    }, 100);
  };

  return (
    <AuthGuard>
      <aside className="dashboard_sidebar">
        <div className="sidbar_close">
          <button className="btn_sidebar" type="button">
            <i className="fa-solid fa-x" />
          </button>
        </div>
        <div className="sidebar_top">
          <Link to="/">
            <img
              src="/fasttrading/images/logo.png"
              className="img-fluid"
              alt="Logo"
            />
          </Link>
        </div>
        <nav className="nav_sidebar">
          <ul className="sidebar_list">
            <li className={`sidebar_item ${location.pathname === "/dashboard/profile" ? "active" : ""}`}>
              <Link to="/dashboard/profile" className="sidebar_link">
                <i className="fa-regular fa-user" />
                <span>Profile</span>
              </Link>
            </li>
            <li className={`sidebar_item ${location.pathname === "/market" ? "active" : ""}`}>
              <Link to="/market" className="sidebar_link">
                <i className="fa-solid fa-chart-line" />
                <span>Market</span>
              </Link>
            </li>
            <li className={`sidebar_item ${location.pathname === "/future" ? "active" : ""}`}>
              <Link to="/future" className="sidebar_link">
                <i className="fa-solid fa-chart-candlestick" />
                <span>Futures</span>
              </Link>
            </li>
            <li className={`sidebar_item ${location.pathname === "/dashboard/wallet" ? "active" : ""}`}>
              <Link to="/dashboard/wallet" className="sidebar_link">
                <i className="fa-solid fa-wallet" />
                <span>Wallet</span>
              </Link>
            </li>
            <li className={`sidebar_item ${location.pathname === "/dashboard/deposit" ? "active" : ""}`}>
              <Link to="/dashboard/deposit" className="sidebar_link">
                <i className="fa-solid fa-download" />
                <span>Deposit</span>
              </Link>
            </li>
            <li className={`sidebar_item ${location.pathname === "/dashboard/withdraw" ? "active" : ""}`}>
              <Link to="/dashboard/withdraw" className="sidebar_link">
                <i className="fa-solid fa-upload" />
                <span>Withdraw</span>
              </Link>
            </li>
            <li className={`sidebar_item ${location.pathname === "/dashboard/payment" ? "active" : ""}`}>
              <Link to="/dashboard/payment" className="sidebar_link">
                <i className="fa-regular fa-credit-card" />
                <span>Payment Method</span>
              </Link>
            </li>
            <li className={`sidebar_item ${location.pathname === "/dashboard/trade-history" ? "active" : ""}`}>
              <Link to="/dashboard/trade-history" className="sidebar_link">
                <i className="fa-solid fa-money-bill-transfer" />
                <span>Trade History</span>
              </Link>
            </li>
            <li className={`sidebar_item ${location.pathname === "/dashboard/kyc" ? "active" : ""}`}>
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
      </aside>
    </AuthGuard>
  );
};

export default SidebarAuth;
