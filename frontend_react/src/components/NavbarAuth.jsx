import React, { useState, useEffect, useContext } from "react";
import axios from "/config/axiosConfig";
import { Link, useLocation } from "react-router-dom";
import { useNavigate } from "react-router-dom"; // Combine imports from react-router-dom
import AuthUser from "../components/AuthUser";
import $ from "jquery"; // Import jQuery

const SidebarAuth = () => {
  const navigate = useNavigate(); // Move useNavigate inside the component

  const { token, logout } = AuthUser();
  const logoutUser = async () => {
    logout();
    localStorage.removeItem("token");

    setTimeout(() => {
      navigate("/login");
    }, 100); // Small delay to allow state update
  };

  return (
    <nav className="navbar navbar-expand-lg">
      <div className="container-fluid">
        <ul className="navbar_secondary  mb-2 mb-lg-0">
          <li className="d-lg-none">
            <button className="btn_sidebar" click="showSidebar" type="button">
              <i className="fa-solid fa-bars" />
            </button>
          </li>
          <li className="nav-item">
            <Link to="/" className="nav-link">
              Home
            </Link>
          </li>
        </ul>
        <ul className="navbar_secondary ms-auto mb-2 mb-lg-0">
          <li className="nav-item dropdown profile_pic">
            <a
              className="nav-link dropdown-toggle"
              href="/market"
              role="button"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
              <i className="fa-solid fa-user" />
              <div>
                <h4>User</h4>
              </div>
            </a>
            <ul className="dropdown-menu">
              <li>
                <Link className="dropdown-item" to="#" onClick={logoutUser}>
                  Logout
                </Link>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
  );
};

export default SidebarAuth;
