import React, { useState, useRef, useEffect } from "react";
import { Helmet } from "react-helmet";
import { useNavigate } from "react-router-dom";
import Sidebar from "../../components/SidebarAuth";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import QRCode from "qrcode";
import { useParams } from "react-router-dom";
import AuthGuard from "../../components/AuthGuard";
import AuthUser from "../../components/AuthUser";
import Loader from "../../components/Loader";

const ChangePassword = () => {
  const navigate = useNavigate();

  const [old_password, setOldPasswordName] = useState("");
  const [new_password, setNewPasswordName] = useState("");
  const [new_password_confirmation, setConfirmPasswordName] = useState("");
  const [errors, setErrors] = useState({});

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const token = JSON.parse(sessionStorage.getItem("token"));
      const formData = new FormData();
      formData.append("old_password", old_password);
      formData.append("new_password", new_password);
      formData.append("new_password_confirmation", new_password_confirmation);
      const response = await axios.post("/auth/updatePassword", formData, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
      });
      const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.onmouseenter = Swal.stopTimer;
          toast.onmouseleave = Swal.resumeTimer;
        },
      });
      Toast.fire({
        icon: "success",
        title: "Has been successfully update",
      });
      //console.log(response.data.message);
      navigate("/dashboard/profile");
    } catch (error) {
      if (error.response && error.response.status === 422) {
        Swal.fire({
          icon: "error",
          title: "Validation Errors",
          html: Object.values(error.response.data.errors)
            .map((err) => `<div>${err.join("<br>")}</div>`)
            .join(""),
        });
        console.error("Validation errors:", error.response.data.errors);
        setErrors(error.response.data.errors);
      } else {
        console.error("Error updating user:", error);
      }
    }
  };

  const handleOldPasswordChange = (e) => {
    setOldPasswordName(e.target.value);
  };
  const handleNewPasswordChange = (e) => {
    setNewPasswordName(e.target.value);
  };
  const handleConfirmPasswordChange = (e) => {
    setConfirmPasswordName(e.target.value);
  };

  const backtoList = () => {
    navigate("/user/profile"); // Adjust the navigation path as needed
  };
 
  return (
    <>
      <Helmet>
        <title>Payment Method</title>
      </Helmet>

      <div>
        {/* Sidebar Start */}
        <Sidebar />
        <AuthGuard />
        {/* Sidebar End */}

        <div className="main_dashboard">
          {/* Top Navbar */}
          <NavbarAuth />
          {/* Top Navbar End */}

          <div className="dashboard_content">
            <div className="row">
              <div className="col-md-12">
                <div className="payment_section">
                  <div className="page_title">
                    <div className="d-flex justify-content-between w-100 align-items-end">
                      <h4>Change Password</h4>
                    </div>
                  </div>

                  {/* Start content */}

                  <form onSubmit={handleSubmit}>
                    <div className="form-group mb-2">
                      <label htmlFor="password">Password</label>
                      <div className="input_group">
                        <input
                          type="password"
                          className="form-control"
                          onChange={handleOldPasswordChange}
                        />
                        {errors.old_password && (
                          <div className="error" style={{ color: "red" }}>
                            {errors.old_password[0]}{" "}
                          </div>
                        )}
                      </div>
                    </div>
                    <div className="form-group mb-2">
                      <label htmlFor="confirmPassword">New Password</label>
                      <div className="input_group">
                        <input
                          type="password"
                          className="form-control"
                          onChange={handleNewPasswordChange}
                        />
                        {errors.new_password && (
                          <div className="error" style={{ color: "red" }}>
                            {errors.new_password[0]}{" "}
                          </div>
                        )}
                      </div>
                    </div>

                    <div className="form-group mb-2">
                      <label htmlFor="confirmPassword">Confirm Password</label>
                      <div className="input_group">
                        <input
                          type="password"
                          className="form-control"
                          onChange={handleConfirmPasswordChange}
                        />
                        {errors.new_password_confirmation && (
                          <div className="error" style={{ color: "red" }}>
                            {errors.new_password_confirmation[0]}{" "}
                          </div>
                        )}
                      </div>
                    </div>
                    <button type="submit" className="signin_btn btn_primary"> Update </button>
                  </form>




                  {/* END content */}
                </div>
              </div>
            </div>
          </div>

          {/* add new modal start here  */}
        </div>
      </div>
    </>
  );
};

export default ChangePassword;
