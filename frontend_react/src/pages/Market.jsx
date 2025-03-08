import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import Navbar from "../components/Navbar";
import Footer from "../components/Footer";
import TradingViewWidgetBTCUSDT from "../components/TradingViewWidgetBTCUSDT";
import TradingViewWidgetETHUSDT from "../components/TradingViewWidgetETHUSDT";
import TradingViewWidgetXRPUSDT from "../components/TradingViewWidgetXRPUSDT";
import TradingViewWidgetBNBUSDT from "../components/TradingViewWidgetBNBUSDT";
import CryptoList from "../components/CryptoListMarket";
import TradingViewWidget from "../components/TradingViewSlider";
import { Link } from "react-router-dom";

const Market = () => {
  const [cryptos, setCryptos] = useState([
    { symbol: "BTC", name: "BTC/USDT", image: "/fasttrading/images/btc.png" },
    { symbol: "ETH", name: "ETH/USDT", image: "/fasttrading/images/eth.png" },
    { symbol: "BNB", name: "BNB/USDT", image: "/fasttrading/images/bnb.png" },
    { symbol: "XRP", name: "XRP/USDT", image: "/fasttrading/images/xrp.png" },
    { symbol: "ADA", name: "ADA/USDT", image: "/fasttrading/images/ada.png" },
    { symbol: "SOL", name: "SOL/USDT", image: "/fasttrading/images/sol.png" },
  ]);
  const getRandomName = () => {
    const names = [
      // Bangladeshi Names
      "Rahim Ahmed", "Karim Hossain", "Hasan Chowdhury", "Shamim Al Mamun", "Ayesha Akter",
      "Fatima Khatun", "Nusrat Jahan", "Samiul Islam", "Tanvir Rahman", "Shafiq Mahmud",
      "Mehedi Hasan", "Faisal Hossain", "Naimur Rahman", "Sadia Rahman", "Sumaiya Islam",
      "Rafiq Sarker", "Jannatul Ferdous", "Tariqul Islam", "Mizanur Rahman", "Shakil Ahmed",
  
      // Indian Names
      "Rajesh Sharma", "Amit Verma", "Pooja Patel", "Sunil Kumar", "Priya Mehta",
      "Ravi Shankar", "Neha Kapoor", "Arjun Reddy", "Sanya Singh", "Deepak Malhotra",
      "Sneha Nair", "Vikram Desai", "Anjali Iyer", "Suresh Ranganathan", "Manish Choudhury",
      "Kiran Rao", "Rahul Bhardwaj", "Meera Joshi", "Nikhil Saxena", "Alok Mishra",
  
      // Pakistani Names
      "Ali Khan", "Mohammad Asif", "Sadia Malik", "Bilal Ahmed", "Ayesha Siddiqui",
      "Hassan Javed", "Fatima Tariq", "Shahid Hussain", "Farhan Sheikh", "Sana Riaz",
      "Zainab Hassan", "Imran Qureshi", "Nadia Yousuf", "Tahir Mahmood", "Feroz Alam",
      "Uzma Butt", "Hamza Saeed", "Adnan Khalid", "Shagufta Anwar", "Waqar Zaman",
  
      // More Mixed Names
      "Nasir Uddin", "Tasnim Ahmed", "Rohan Gupta", "Anurag Sen", "Shivangi Thakur",
      "Javed Iqbal", "Sara Noor", "Mohsin Raza", "Mahbub Alam", "Saima Yasmin",
      "Yasir Hossain", "Nabila Sultana", "Tanzim Rahman", "Sakib Chowdhury", "Afzal Karim",
      "Tanisha Farooqui", "Azhar Shah", "Rehman Khan", "Aarav Malhotra", "Nida Pervez",
      "Zubair Ahmed", "Fahim Hossain", "Sadia Zaman", "Ashfaq Jamil", "Kamrul Hasan",
      "Sohail Anwar", "Rubina Akhter", "Nashit Rehman", "Abdul Samad", "Tanzeel Haque"
    ];
  
    return names[Math.floor(Math.random() * names.length)];
  };
  
  const generateRandomData = () => {
    const tradeAmount = Math.random() * 50000; // Max $50,000
    const randomGain = Math.random() * 10; // Max 10%
  
    return {
      name: getRandomName(),
      tradeAmountNum: tradeAmount,
      tradeAmount: `$${tradeAmount.toFixed(2)}`,
      gainNum: randomGain,
      gain: `+${randomGain.toFixed(2)}%`,
    };
  };
  
  const [tableData, setTableData] = useState([]);
  
  useEffect(() => {
    const data = [];
    for (let i = 0; i < 10; i++) {
      data.push(generateRandomData());
    }
  
    // Sort by trade amount first, then by gain percentage if trade amounts are equal
    data.sort((a, b) => {
      if (b.tradeAmountNum !== a.tradeAmountNum) {
        return b.tradeAmountNum - a.tradeAmountNum; // Sort by trade amount (high to low)
      }
      return b.gainNum - a.gainNum; // If trade amount is same, sort by gain percentage (high to low)
    });
  
    setTableData(data);
  }, []);
  

  return (
    <>
      <Helmet>
        <title>Market</title>
      </Helmet>
      <Navbar />

      {/* TopRatedCryptocurrencies component */}
      <div className="container-fluid">
        <div className="row">
          <div className="col-6 col-md-3">
            <div className="top_rated">
              <TradingViewWidgetBTCUSDT symbol="BINANCE:BTCUSDT" />
            </div>
          </div>

          <div className="col-6 col-md-3">
            <div className="top_rated">
              <TradingViewWidgetETHUSDT symbol="BINANCE:ETHUSDT" />
            </div>
          </div>

          <div className="col-6 col-md-3">
            <div className="top_rated">
              <TradingViewWidgetXRPUSDT symbol="BINANCE:XRPUSDT" />
            </div>
          </div>

          <div className="col-6 col-md-3">
            <div className="top_rated">
              <TradingViewWidgetBNBUSDT />
            </div>
          </div>
        </div>
        <div className="bt_container_home">

          <div className="text-center">
            <Link to="/dashboard/deposit" className="btn_primary">
              <i className="fa-solid fa-download me-md-2"></i>
              <span className="d-none d-lg-block">Deposit</span>
            </Link>
            <span className="text-center text-white d-md-none" style={{ fontSize: "12px" }}>Deposit</span>
          </div>
          <div className="text-center ">

            <Link to="/dashboard/withdraw" className="btn_primary">
              <i className="fa-solid fa-upload me-md-2"></i>
              <span className="d-none d-lg-block">Withdraw</span>
            </Link>
            <span className="text-center text-white d-md-none" style={{ fontSize: "12px" }}>Withdraw</span>
          </div>
          <div className="text-center ">
            <Link to="/future/btc" className="btn_primary">
              <i className="fa-solid fa-chart-candlestick me-md-2"></i>
              <span className="d-none d-lg-block">Future</span>
            </Link>
            <span className="text-center text-white d-md-none" style={{ fontSize: "12px" }}>Future</span>
          </div>
          <div className="text-center">
            <Link to="/dashboard/trade-history" className="btn_primary">
              <i className="fa-solid fa-shield-quartered"></i>
              <span className="d-none d-lg-block">&nbsp;Trade History</span>
            </Link>
            <span className="text-center text-white d-md-none" style={{ fontSize: "12px" }}>Sequrity</span>
          </div>
        </div>

        {/* tape widget */}
        <div className="row mt-3">
          <div className="col-md-12">
            <div className="tape_widget">
              <TradingViewWidget />
            </div>
          </div>
        </div>
      </div>

      {/* Coin Price Table */}
      <div className="col-md-12">
        <div className="title">
          <h3>Top Rated Cryptocurrencies</h3>
        </div>
      </div>
      <div className="col-md-12">
        <div className="crypto_table">
          <table className="table table-dark table-striped">
            <thead>
              <tr>
                <th className="text-center pc_view">Rank</th>
                <th>Name</th>
                <th className="pc_view text-center">24 Hour Volume</th>
                <th className="pc_view text-center">Price</th>
                {/* <th>30 Day</th> */}
                <th>Change(30 Day)</th>
              </tr>
            </thead>

            <CryptoList />
           
          </table>
        </div>
      </div>

      {/* Top Traders */}
      <div className="col-md-12">
        <div className="title">
          <h3>Top Traders</h3>
        </div>
      </div>
      <div className="col-md-12">
        <div className="top_gainer">
          <table className="table table-dark table-striped">
            <thead>
              <tr>
                <th className="text-center">User</th>
                <th className="text-center">Trade Amount</th>
                <th className="text-center">Today's Gain</th>
              </tr>
            </thead>
            <tbody>
              {tableData.map((data, index) => (
                <tr key={index}>
                  <td className="text-center"><h2>{getRandomName()}</h2></td>
                  <td className="text-center"><h2 className="td_amt">{data.tradeAmount}</h2></td>
                  <td className={`text-center ${data.gain.startsWith("+") ? "text-success" : "text-danger"}`}>
                    <h2 className="td_amt">{data.gain}</h2>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <Footer />
    </>
  );
};

export default Market;
