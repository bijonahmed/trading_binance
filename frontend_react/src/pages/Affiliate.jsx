import React, { useState, useEffect, useContext } from "react";
import { Helmet } from "react-helmet";
import Navbar from "../components/Navbar";
import Footer from "../components/Footer";
import { Link, useParams, useNavigate } from "react-router-dom";
import axios from "/config/axiosConfig";
import AuthUser from "../components/AuthUser";

import LeftSideBarComponent from "../components/LeftSideBarComponent";
import LeftSideBarComponentPlt from "../components/LeftSideBarComponentAlllGames";
import Loader from "../components/Loader";
import "../components/css/allGamesList.css"; // Import your CSS file
import Carousel from "react-bootstrap/Carousel";

const Affiliate = () => {

  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [responseData, setResponseData] = useState([]);
  const [teamCount, setTeamCount] = useState(0);
  const { getToken, token, logout } = AuthUser();
  const [levelName, setLevelName] = useState("");
  const [index, setIndex] = useState(0);
  const [dateForm, setDateForm] = useState("");
  const [dateTo, setDateTo] = useState("");
  const [showLevel, sendLevel] = useState("");
  const level1Data = responseData["1"] || [];

  const handleDateChangeFrm = (event) => {
    setDateForm(event.target.value); // Update state with the selected date
  };

  const handleDateChangeTo = (event) => {
    setDateTo(event.target.value); // Update state with the selected date
  };

  const defaultFetch = async (level) => {
    sendLevel(level);
    const levels = [
      "All",
      "Level-1",
      "Level-2",
      "Level-3",
      "Level-4",
      "Level-5",
    ];
    setLevelName(levels[level] || "Unknown");
    setLoading(true);
    try {
      const response = await axios.get("/user/makeAffilaiteReport", {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
        params: {
          level: level,
          frmDate: dateForm,
          toDate: dateTo,
        },
      });

      console.log("Response data:", response.data.level_data);
      setResponseData(response.data.level_data);
      setTeamCount(response.data.teamCount);
    } catch (error) {
      console.error("Error Data:", error);
      if (error.response && error.response.status === 401) {
        // Handle unauthorized access (e.g., redirect to login)
        console.log("Unauthorized: Redirecting to login...");
      }
    } finally {
      setLoading(false);
    }
  };
  const filterLevels = [0, 1, 2, 3, 4, 5];
  useEffect(() => {
    defaultFetch(0);
  }, []); // Dependency array includes slug and currentPage

  return (
    <>
      <div style={{ height: 54 }} />
      <Navbar />

      <div className="container-fluid" style={{ minHeight: "100vh" }}>
        <div className="row">
          <div className="col-2" style={{ marginTop: "-50px" }}>
            <LeftSideBarComponent />
          </div>
          <div className="col-10 mt-4">
            <div>
              {/* Start */}
              <div>
                <div className="row">
                  <h4 className="text-center">Affiliate History</h4>
                  <center>{levelName}</center>
                </div>
                {/* table part start here  */}
                <div className="row">
                  <div className="col-12">
                    <div className="tab_btns">
                      <ul
                        className="nav nav-pills mb-3"
                        id="pills-tab"
                        role="tablist"
                      >
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link"
                            id="pills-all-tab"
                            data-bs-toggle="pill"
                            data-bs-target="#pills-all"
                            type="button"
                            role="tab"
                            aria-controls="pills-all"
                            aria-selected="true"
                            onClick={() => defaultFetch(0)}
                          >
                            All
                          </button>
                        </li>
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link"
                            id="pills-l_one-tab"
                            onClick={() => defaultFetch(1)}
                            type="button"
                          >
                            Level-1
                          </button>
                        </li>
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link"
                            id="pills-l_one-tab"
                            onClick={() => defaultFetch(2)}
                            type="button"
                          >
                            Level-2
                          </button>
                        </li>
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link"
                            id="pills-l_one-tab"
                            onClick={() => defaultFetch(3)}
                            type="button"
                          >
                            Level-3
                          </button>
                        </li>
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link"
                            id="pills-l_one-tab"
                            onClick={() => defaultFetch(4)}
                            type="button"
                          >
                            Level-4
                          </button>
                        </li>
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link"
                            id="pills-l_one-tab"
                            onClick={() => defaultFetch(5)}
                            type="button"
                          >
                            Level-5
                          </button>
                        </li>
                      </ul>
                    </div>
                  </div>
                </div>

                <div className="tab-content" id="pills-tabContent">
                  <div
                    className="tab-pane fade show active"
                    id="pills-all"
                    role="tabpanel"
                    aria-labelledby="pills-all-tab"
                    tabIndex={0}
                  >
                    {/* all part start here  */}
                    <div className="row">
                      <div className="co-md-6 col-sm-12 col-12">
                        <div className="trasnsection_history">
                          <br />
                          <div className="row filter">
                            <div className="col-lg-4">
                              <div className="row">
                                <div className="col-9">
                                  <button className="btn_filter active">
                                    Total Members: {teamCount}
                                  </button>
                                </div>
                                {/* <div className="col-3">
                                  <button className="btn_filter">
                                    Yesterday
                                  </button>
                                </div>
                                <div className="col-3">
                                  <button className="btn_filter">
                                    Last Week
                                  </button>
                                </div>
                                <div className="col-3">
                                  <button className="btn_filter">
                                    Last Month
                                  </button>
                                </div> */}
                              </div>
                            </div>
                            <div className="col-lg-8">
                              <div className="row">
                                <div className="col-8">
                                  {loading ? (
                                    <center>
                                      <Loader />
                                    </center>
                                  ) : (
                                    <div className="row align-items-center">
                                      <div className="col-4 p-0">
                                        <input
                                          type="date"
                                          className="form-control"
                                          value={dateForm}
                                          onChange={handleDateChangeFrm}
                                        />
                                      </div>
                                      <div className="col-1 p-0">
                                        <h5>To</h5>
                                      </div>
                                      <div className="col-4 p-0">
                                        <input
                                          type="date"
                                          className="form-control"
                                          value={dateTo}
                                          onChange={handleDateChangeTo}
                                        />
                                      </div>
                                      <div className="col-3">
                                        {filterLevels.includes(showLevel) && (
                                          <button
                                            className="btn_find ms-2"
                                            onClick={() =>
                                              defaultFetch(showLevel)
                                            }
                                          >
                                            Filter By Level:{" "}
                                            {showLevel === 0
                                              ? "All"
                                              : `${showLevel}`}
                                          </button>
                                        )}
                                      </div>
                                    </div>
                                  )}
                                </div>
                              </div>
                            </div>
                          </div>

                          {showLevel === 0 && (
                            <div>
                              {Object.keys(responseData).map((level) => (
                                <div key={level}>
                                  <h5>Level {level}</h5>
                                  <table
                                    className="table"
                                    style={{ fontSize: "12px" }}
                                  >
                                    <thead>
                                      <tr>
                                        <th>SL.</th>
                                        <th>FG ID</th>
                                        <th>Invite Code</th>
                                        <th>Name</th>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Ref Name</th>
                                        <th>Created Date</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      {responseData[level]?.length > 0 ? (
                                        responseData[level].map(
                                          (item, index) => (
                                            <tr key={item.id}>
                                              <td>{index + 1}</td>
                                              <td>{item.fg_id}</td>
                                              <td>{item.inviteCode}</td>
                                              <td>{item.name}</td>
                                              <td>{item.username}</td>
                                              <td>{item.email}</td>
                                              <td>{item.ref_name}</td>
                                              <td>{item.createdat}</td>
                                            </tr>
                                          )
                                        )
                                      ) : (
                                        <tr>
                                          <td colSpan="8">No data available</td>
                                        </tr>
                                      )}
                                    </tbody>
                                  </table>
                                </div>
                              ))}
                            </div>
                          )}

                          {showLevel !== 0 && (
                            <table
                              className="table"
                              style={{ fontSize: "12px" }}
                            >
                              <thead>
                                <tr>
                                  <th>SL.</th>
                                  <th>User Name</th>
                                  <th>Refer By</th>
                                  <th>Created Date</th>
                                </tr>
                              </thead>
                              <tbody>
                                {Array.isArray(responseData) &&
                                responseData.length > 0 ? (
                                  responseData.map((item, index) => (
                                    <tr key={index}>
                                      <td>{index + 1}</td>
                                      <td>{item.username}</td>
                                      <td>{item.ref_name}</td>
                                      <td>{item.createdat}</td>
                                    </tr>
                                  ))
                                ) : (
                                  <tr>
                                    <td colSpan="4">No data available</td>
                                  </tr>
                                )}
                              </tbody>
                            </table>
                          )}
                        </div>
                      </div>
                    </div>
                    {/* all part end here  */}
                  </div>
                </div>
              </div>

              {/* END */}
            </div>
            <br />
          </div>
        </div>
      </div>

      <div className="container">
        <div className="row ">
          <div className="col-md-12" style={{ height: 90 }} />
        </div>
      </div>
      <Footer />

      {/* END */}
    </>
  );
};

export default Affiliate;
