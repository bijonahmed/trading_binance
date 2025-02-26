import React, { useState } from "react";
import { Helmet } from "react-helmet";
import Navbar from "../../components/Navbar";
import Footer from "../../components/Footer";
import Sidebar from "../../components/SidebarAuth";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import QRCode from "qrcode";
import { useParams } from "react-router-dom";
import AuthGuard from "../../components/AuthGuard";
const TradeHistory = () => {
  const [hasRequested, setHasRequested] = useState(false);

  return (
    <>
      <Helmet>
        <title>Trade History</title>
      </Helmet>

      <div>
        {/* Sidebar Start */}
        <Sidebar />
        {/* Sidebar End */}

        <div className="main_dashboard">
          {/* Top Navbar */}
          <NavbarAuth />
          <AuthGuard/>
          {/* Top Navbar End */}

          {/* Start */}
          <div className="dashboard_content">
            <div className="row">
              <div className="col-md-12">
                <div className="payment_section">
                  <div className="page_title">
                    <a
                      href="#"
                      className="btn_back"
                      click="history.back(); return false;"
                    >
                      <i className="fa-solid fa-arrow-left" />
                    </a>
                  </div>
                </div>
                {/* balance */}
                <div className="balance_container">
                  <div className="balance_box">
                    <h5>Estimated Balance</h5>
                    <h4>
                      0.00 <span>USDT</span>{" "}
                    </h4>
                    <h6>$0.00</h6>
                  </div>
                  <div className="row">
                    <div className="col-md-8 ms-auto">
                      <div className="btns_list">
                        {/* data-bs-toggle="modal" data-bs-target="#deposit_modal"  */}
                        <Link
                          to="/dashboard/deposit"
                          role="button"
                          className="btn_primary"
                        >
                          Deposit
                        </Link>
                        <Link to="/dashboard/withdraw" className="btn_primary">
                          Withdraw
                        </Link>
                        {/* <a href="" class="btn_primary"></a> */}
                      </div>
                    </div>
                  </div>
                </div>
                {/* history section start here  */}
                <div className="page_title">
                  <div className="d-flex justify-content-between w-100 align-items-end">
                    <h4>Trade History</h4>
                  </div>
                </div>
                <div className="row">
                  <div className="col-md-12">
                    <div className="search_section">
                      <form action="">
                        <div className="search_div">
                          <div className="row">
                            <div className="col-md-6">
                              <div className=" d-flex align-items-center w-100">
                                <div className="input_form w-100">
                                  <input
                                    type="text"
                                    placeholder="Search TRX id"
                                    className="form-control mb-2"
                                  />
                                </div>
                                <div className="input_form w-100 m-0">
                                  <select className="form-control mb-2">
                                    <option>
                                      All
                                    </option>
                                    <option>Long </option>
                                    <option>Short</option>
                                  </select>
                                </div>
                              </div>
                            </div>
                            <div className="col-md-6">
                              <div className=" d-flex align-items-center justify-content-md-start justify-content-center">
                                <div className="input_form date_">
                                  <input
                                    type="date"
                                    className="form-control mb-2"
                                  />
                                </div>
                                <p>TO</p>
                                <div className="input_form date_ m-0">
                                  <input
                                    type="date"
                                    className="form-control mb-2"
                                  />
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </form>
                    </div>
                    <div className="table-responsive">
                      <ul className="transec_tb_mobile trande_ mobile_view">
                        <li>
                          <p>Trx: TRX8784345</p>
                          <p>
                            <span className="badge bg-success">By Long</span>
                          </p>
                          <p>Cross: BTCUSDT</p>
                          <p>Filled USDT: $100.00</p>
                          <p>Open: 2024-08-10 15:10:00</p>
                          <p>Close: 2024-08-10 15:10:00</p>
                          <p>Entry Price: $60850.00</p>
                          <p>Av. Close Price: $60950.00</p>
                          <p>Funding Fee: $1.00</p>
                          <p>
                            PNL:{" "}
                            <span className="badge bg-success">$110.00</span>
                          </p>
                        </li>
                        <li>
                          <p>Trx: TRX8784345</p>
                          <p>
                            <span className="badge bg-danger">Sell Short</span>
                          </p>
                          <p>Open: 2024-08-10 15:10:00</p>
                          <p>Cross: BTCUSDT</p>
                          <p>Entry Price: $60850.00</p>
                          <p>Close: 2024-08-10 15:10:00</p>
                          <p>Av. Close Price: $60950.00</p>
                          <p>Filled USDT: $100.00</p>
                          <p>Funding Fee: $1.00</p>
                          <p>
                            PNL:{" "}
                            <span className="badge bg-danger">-$100.00</span>
                          </p>
                        </li>
                        <li>
                          <p>Trx: TRX8784345</p>
                          <p>
                            <span className="badge bg-success">Long</span>
                          </p>
                          <p>Open: 2024-08-10 15:10:00</p>
                          <p>Cross: BTCUSDT</p>
                          <p>Entry Price: $60850.00</p>
                          <p>Close: 2024-08-10 15:10:00</p>
                          <p>Av. Close Price: $60950.00</p>
                          <p>Filled USDT: $100.00</p>
                          <p>Funding Fee: $1.00</p>
                          <p>
                            PNL:{" "}
                            <span className="badge bg-success">$110.00</span>
                          </p>
                        </li>
                      </ul>
                      <table className="table table-hover table-dark table-striped table-hover pc_view">
                        <thead>
                          <tr>
                            <th className="col">TRX id</th>
                            <th>Type</th>
                            <th>Open Time</th>
                            <th>Perp Cross</th>
                            <th>Entry Price</th>
                            <th>Close time</th>
                            <th>Avg. Close Price</th>
                            <th>Filled USDT</th>
                            <th>Funding Fee</th>
                            <th>Closing PNL</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>TRX8784345</td>
                            <td>
                              <span className="badge bg-success">Long</span>
                            </td>
                            <td>
                              2024-08-10 <br /> 15:10:00
                            </td>
                            <td>BTCUSDT</td>
                            <td>$60850.00</td>
                            <td>
                              2024-08-10 <br /> 15:10:30
                            </td>
                            <td>$60950.00</td>
                            <td>$100.00</td>
                            <td>$1.00</td>
                            <td>
                              <span className="badge bg-success">$110.00</span>
                            </td>
                          </tr>
                          <tr>
                            <td>TRX8784345</td>
                            <td>
                              <span className="badge bg-success">Long</span>
                            </td>
                            <td>
                              2024-08-10 <br /> 15:10:00
                            </td>
                            <td>BTCUSDT</td>
                            <td>$60950.00</td>
                            <td>
                              2024-08-10 <br /> 15:10:30
                            </td>
                            <td>$60850.00</td>
                            <td>$100.00</td>
                            <td>$1.00</td>
                            <td>
                              <span className="badge bg-danger">-$100.00</span>
                            </td>
                          </tr>
                          <tr>
                            <td>TRX8784345</td>
                            <td>
                              <span className="badge bg-danger">Short</span>
                            </td>
                            <td>
                              2024-08-10 <br /> 15:00:00
                            </td>
                            <td>BTCUSDT</td>
                            <td>$60850.00</td>
                            <td>
                              2024-08-10 <br /> 15:00:30
                            </td>
                            <td>$60840.00</td>
                            <td>$100.00</td>
                            <td>$1.00</td>
                            <td>
                              <span className="badge bg-success">$110.00</span>
                            </td>
                          </tr>
                          <tr>
                            <td>TRX8784345</td>
                            <td>
                              <span className="badge bg-danger">Short</span>
                            </td>
                            <td>
                              2024-08-10 <br /> 15:00:00
                            </td>
                            <td>BTCUSDT</td>
                            <td>$60850.00</td>
                            <td>
                              2024-08-10 <br /> 15:00:30
                            </td>
                            <td>$60950.00</td>
                            <td>$100.00</td>
                            <td>$1.00</td>
                            <td>
                              <span className="badge bg-danger">-$100.00</span>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* END */}
        </div>
      </div>
    </>
  );
};

export default TradeHistory;
