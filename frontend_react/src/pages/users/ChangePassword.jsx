import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import { Link } from "react-router-dom";
import Navbar from "../../components/Navbar";
import Footer from "../../components/Footer";
import { useNavigate } from "react-router-dom";
import axios from "/config/axiosConfig";
import Loader from "../../components/Loader";
import Swal from "sweetalert2";
import AuthUser from "../../components/AuthUser";
import LeftSideBarComponentPlt from "../../components/LeftSideBarComponentAlllGames";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";

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
      navigate("/user/profile");
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
  useEffect(() => {}, []);
  return (
    <>
      <div style={{ height: 54 }} />
      <Navbar />

      <div className="container-fluid" style={{ minHeight: "100vh" }}>
        <div className="row">
          <div className="col-2" style={{ marginTop: "-50px" }}>
            <LeftSideBarComponent />
          </div>
          <div className="col-8 mt-4">
            <center>
              <u>Profile Information</u>
            </center>

            {/* Start */}

            <div className="row">
              <div className="col-lg-4 col-md-6 m-auto col-sm-12">
                <center>
                  <button onClick={backtoList}>
                    {" "}
                    <i className="fas fa-arrow-left me-0"></i>{" "}
                  </button>
                </center>
                <div className="register login" style={{ marginTop: "-10px" }}>
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
                    <button
                      type="submit"
                      className="signin_btn"
                    >
                      Update
                    </button>
                  </form>
                </div>
              </div>
            </div>

            {/* END */}
          </div>
          <div className="col-2" style={{ marginTop: "-50px" }}>
            <LeftSideBarComponentPlt />
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

export default ChangePassword;
