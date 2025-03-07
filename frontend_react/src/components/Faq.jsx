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
      <section className="faq_section">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <div className="faq_contents">
                <h1 className="faq_title">Frequently Asked Questions</h1>
                <div
                  className="accordion accordion-flush"
                  id="accordionFlushExample"
                >
                  <div className="accordion-item">
                    <h2 className="accordion-header">
                      <button
                        className="accordion-button collapsed"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#flush-collapseOne"
                        aria-expanded="false"
                        aria-controls="flush-collapseOne"
                      >
                        What is a cryptocurrency exchange?
                      </button>
                    </h2>
                    <div
                      id="flush-collapseOne"
                      className="accordion-collapse collapse"
                      data-bs-parent="#accordionFlushExample"
                    >
                      <div className="accordion-body">
                        A cryptocurrency exchange is an online platform where users can buy, sell, and trade digital assets like Bitcoin (BTC), Ethereum (ETH), and Tether (USDT). Liquidcoin is a fast, secure, and user-friendly exchange designed to provide seamless crypto trading for both beginners and experienced traders.
                      </div>
                    </div>
                  </div>
                  <div className="accordion-item">
                    <h2 className="accordion-header">
                      <button
                        className="accordion-button collapsed"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#flush-collapseTwo"
                        aria-expanded="false"
                        aria-controls="flush-collapseTwo"
                      >
                        How to trade cryptocurrencies on Liquidcoin
                      </button>
                    </h2>
                    <div
                      id="flush-collapseTwo"
                      className="accordion-collapse collapse"
                      data-bs-parent="#accordionFlushExample"
                    >
                      <div className="accordion-body">
                        <h6>Liquidcoin offers multiple trading options to suit different strategies, including:</h6>

                        <ul>
                          <li>Spot Trading: Instantly buy and sell cryptocurrencies at live market prices.</li>
                          <li>Margin Trading: Amplify your trades with leverage for greater potential returns.</li>
                          <li>Futures & Options: Trade contracts based on future price movements with advanced risk management tools.</li>
                        </ul>
                        <h6>Getting Started with Liquidcoin</h6>
                        <ul>
                          <li>Sign up for a Liquidcoin account.</li>
                          <li>Complete identity verification to ensure account security and compliance.</li>
                          <li>Deposit funds or purchase crypto using supported payment methods.</li>
                          <li>Start trading and explore various market opportunities.</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Footer;
