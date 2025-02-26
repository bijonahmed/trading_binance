import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import Sidebar from "../../components/SidebarAuth";
import NavbarAuth from "../../components/NavbarAuth";
import AuthUser from "../../components/AuthUser";
import AuthGuard from "../../components/AuthGuard";
import { Link, useNavigate } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import QRCode from "qrcode";
import { useParams } from "react-router-dom";
import { format } from "date-fns";

const Profile = () => {
  const navigate = useNavigate();
  const [hasRequested, setHasRequested] = useState(false);
  const { token } = AuthUser();
  const [userData, setUserData] = useState(0);
  const [loading, setLoading] = useState(true);
  const [phoneNumber, setPhoneNumber] = useState("");
  const [email, setEmail] = useState("");

  const [errors, setErrors] = useState({});

  const getProfiledata = async () => {
    try {
      const response = await axios.get(`/user/checkuser`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        }, // Removed the extra comma here
      });
      const responseData = response.data;
      setUserData(responseData);
      setPhoneNumber(userData.phone_number);
    } catch (error) {
      console.error("Error Data:", error);
    }
  };

  const managePassword = () => {
    navigate("/change-password");

  }


  const handleInputChange = (e) => {
    setPhoneNumber(e.target.value); // Ensure input updates correctly
  };

  const handleInputChangeEmail = (e) => {
    setEmail(e.target.value); // Ensure input updates correctly
  };


  const handleSubmitEmail = async (e) => {
    e.preventDefault();
    
    try {
      const formData = new FormData();
      formData.append("email", email);

      const response = await axios.post(`/user/updateUserEmail`, formData, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
      });
      console.log("Live request response:", response.data);
      $.notify("Successfully update!", "success");
      getProfiledata();
      $("#emailModal").modal("hide");
    } catch (error) {
      console.error("Registration error:", error);

      if (error.response) {
        console.error("Error response data:", error.response.data);
        if (error.response.data.errors) {
          setErrors(error.response.data.errors); // Set errors from API response
        } else {
          $.notify(
            error.response.data.message || "Something went wrong!",
            "error"
          );
        }
      } else {
        $.notify("Network error. Please try again.", "error");
      }
    } finally {
      setLoading(false);
    }
  };


  const handleSubmit = async (e) => {
    e.preventDefault();
    console.log("phoneNumber:" + phoneNumber);
    try {
      const formData = new FormData();
      formData.append("phoneNumber", phoneNumber);

      const response = await axios.post(`/user/updateUserPhone`, formData, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
      });
      console.log("Live request response:", response.data);
      $.notify("Successfully update!", "success");
      getProfiledata();
      $("#phoneModal").modal("hide");
    } catch (error) {
      console.error("Registration error:", error);

      if (error.response) {
        console.error("Error response data:", error.response.data);
        if (error.response.data.errors) {
          setErrors(error.response.data.errors); // Set errors from API response
        } else {
          $.notify(
            error.response.data.message || "Something went wrong!",
            "error"
          );
        }
      } else {
        $.notify("Network error. Please try again.", "error");
      }
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    getProfiledata();
  }, []); // Runs only once when the component mounts

  useEffect(() => {
    if (userData?.phone_number) {
      setPhoneNumber(userData.phone_number);
    }
    if (userData?.email) {
      setEmail(userData.email);
    }
  }, [userData]); // Runs only when userData updates

  return (
    <>
      <AuthGuard />
      <Helmet>
        <title>Profile</title>
      </Helmet>

      <div>
        {/* Sidebar Start */}
        <Sidebar />
        {/* Sidebar End */}

        <div className="main_dashboard">
          {/* Top Navbar */}
          <NavbarAuth />
          {/* Top Navbar End */}

          <div className="dashboard_content">
            <div className="row">
              <div className="col-md-12">
                <div className="row mb-3">
                  <div className="col-md-6">
                    <div className="profile_information">
                      {/* <img src="images/eos.png" alt="" class="img-fluid"> */}
                      <i className="fa-solid fa-user" />
                      <div>
                        <h4>{userData.name}</h4>
                        <p>@{userData.username}</p>
                      </div>
                    </div>
                  </div>
                  <div className="col-md-4 ms-auto">
                    <div className="btns_list">
                      <Link to="/dashboard/deposit" className="btn_primary">
                        Deposit
                      </Link>
                      <Link to="/dashboard/withdraw" className="btn_primary">
                        Withdraw
                      </Link>
                    </div>
                  </div>
                </div>
                <div className="details_card">
                  <h4>Personal information</h4>
                  <ul>
                    <li>
                      <p>User name</p>
                      <p>@{userData.username}</p>
                    </li>
                    <li>
                      <p>Full name</p>
                      <p>{userData.name}</p>
                    </li>
                    <li>
                      <p>Intive Code</p>
                      <p>{userData.inviteCode}</p>
                    </li>
                    <li>
                      <p>Email</p>
                      <p>{userData.email}</p>
                    </li>
                    <li>
                      <p>Register IP</p>
                      <p>{userData.register_ip}</p>
                    </li>
                    <li>
                      <p>Register Date</p>
                      <p>{userData.createDate}</p>
                    </li>
                  </ul>
                </div>
                <div className="details_card">
                  <h4>Security</h4>
                  <ul>
                    <li>
                      <p>Phone</p>
                      <p>
                        {userData.phone_number
                          ? userData.phone_number
                          : "xxxxxxxxxxx"}
                        <button
                          className="btn_edit"
                          type="button"
                          data-bs-toggle="modal"
                          data-bs-target="#phoneModal"
                        >
                          Manage
                        </button>
                      </p>
                    </li>
                    <li>
                      <p>Email </p>
                      <p>
                        {userData.email}
                        <button
                          className="btn_edit"
                          type="button"
                          data-bs-toggle="modal"
                          data-bs-target="#emailModal"
                        >
                          Manage
                        </button>
                      </p>
                    </li>
                    <li>
                      <p>Password</p>
                      <p>
                        ********<button className="btn_edit" onClick={managePassword}>Manage</button>
                      </p>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>

          {/* Dashboard Content End */}

          {/* phone modal  */}
          <div
            className="modal fade"
            id="phoneModal"
            tabIndex={-1}
            aria-labelledby="boostModalLabel"
            aria-modal="true"
            role="dialog"
          >
            <div className="modal-dialog modal-dialog-centered">
              <div className="modal-content rounded-0">
                <div className="modal-header py-0">
                  <div className="w-10"> </div>
                  <h5 className="modal-title fs-6" id="boostModalLabel" />
                  <div data-bs-theme="dark">
                    <button
                      type="button"
                      className="btn_close text-white"
                      data-bs-dismiss="modal"
                      aria-label="Close"
                    >
                      <i className="fas fa-times" />
                    </button>
                  </div>
                </div>
                <div className="modal-body">
                  <div className="form_group">
                    <div className="st_filter">
                      <form onSubmit={handleSubmit} className="withdraw_form">
                        <div id="additionalFields2">
                          <div className="form_group mb-2">
                            <p>
                              Phone <span className="text-danger"></span>{" "}
                            </p>
                            <input
                              type="text"
                              placeholder="Phone"
                              className="form-control mb-0"
                              value={phoneNumber}
                              onChange={handleInputChange} // Handle input change
                            />
                            {errors.phoneNumber && (
                              <div className="error text-danger">
                                {errors.phoneNumber}
                              </div>
                            )}
                          </div>
                        </div>
                        <button type="submit" className="btn_action w-100 mt-2">
                          Save
                        </button>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          {/*end phone modal  */}

          {/* email modal  */}
          <div
            className="modal fade"
            id="emailModal"
            tabIndex={-1}
            aria-labelledby="boostModalLabel"
            aria-modal="true"
            role="dialog"
          >
            <div className="modal-dialog modal-dialog-centered">
              <div className="modal-content rounded-0">
                <div className="modal-header py-0">
                  <div className="w-10"> </div>
                  <h5 className="modal-title fs-6" id="boostModalLabel" />
                  <div data-bs-theme="dark">
                    <button
                      type="button"
                      className="btn_close text-white"
                      data-bs-dismiss="modal"
                      aria-label="Close"
                    >
                      <i className="fas fa-times" />
                    </button>
                  </div>
                </div>
                <div className="modal-body">
                  <div className="form_group">
                    <div className="st_filter">
                      <form onSubmit={handleSubmitEmail} className="withdraw_form">
                        <div id="additionalFields2">
                          <div className="form_group mb-2">
                            <p>
                              Email <span className="text-danger"></span>{" "}
                            </p>
                            <input
                              type="text"
                              placeholder="Email"
                              className="form-control mb-0"
                              value={email}
                              onChange={handleInputChangeEmail} // Handle input change
                            />
                            {errors.email && (
                              <div className="error text-danger">
                                {errors.email}
                              </div>
                            )}
                          </div>
                        </div>
                        <button type="submit" className="btn_action w-100 mt-2">
                          Save
                        </button>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          {/*end phone modal  */}
        </div>
      </div>
    </>
  );
};

export default Profile;
