import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import Navbar from "../components/Navbar";
import Footer from "../components/Footer";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import Loader from "../components/Loader";
import AuthUser from "../components/AuthUser";
import axios from "/config/axiosConfig";

const Withdraw = () => {
  const [amount, setAmount] = useState("");

  useEffect(() => {
 
  }, []);
  return (
    <>
      <Helmet>
        <title>Withdrawal</title>
      </Helmet>
     
      <Navbar />

 
      <Footer />
    </>
  );
};

export default Withdraw;
