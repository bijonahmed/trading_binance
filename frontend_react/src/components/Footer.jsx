import React, { useState, useEffect, useContext } from "react";
import { Link } from "react-router-dom";
import { useNavigate } from 'react-router-dom'; // Combine imports from react-router-dom
import AuthUser from "../components/AuthUser";
const Footer = () => {

  const navigate = useNavigate(); // Move useNavigate inside the component


  const { token, logout } = AuthUser();

  const logoutUser = async () => {
    if (token) {
      await logout();
      navigate('/login');
    }
  };

  return (
    <>
        <footer>
          <div className="container">
            <div className="row">
              <div className="col-md-12">
                <div className="footer">
                  <p>©Copyright 2025</p>
                </div>
              </div>
            </div>
          </div>
        </footer>
    </>
  );
};

export default Footer;
