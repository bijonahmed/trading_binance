import React, { useState } from "react";
import { Helmet } from "react-helmet";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";

import AuthUser from "../components/AuthUser";
import { Link } from "react-router-dom";
import Footer from "../components/Footer";
import "../components/css/Login.css"; // Import your CSS file
const Login = () => {
  const navigate = useNavigate();
  const [modalMessage, setModalMessage] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [errors, setErrors] = useState({});
  const [isLoading, setIsLoading] = useState(false); // New state for loading
  const { http, setToken } = AuthUser();

  const validate = () => {
    let newErrors = {};
    if (!username) newErrors.username = "Username is required.";
    if (!password) newErrors.password = "Password is required.";
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!validate()) return;

    setIsLoading(true);

    try {
      const response = await http.post("/auth/userLogin", {
        username,
        password,
      });

      setToken(response.data.user, response.data.access_token);
      $.notify("Login successfully!", "success");
      setTimeout(() => navigate("/dashboard/profile"), 1000);
    } catch (error) {
      const status = error.response?.status;
      const fieldErrors = error.response?.data.errors || {};

      if (status === 403) {
        // Show inactive user modal
        const inactiveMessage = fieldErrors.account
          ? fieldErrors.account[0]
          : "Your account is inactive.";
        setModalMessage(inactiveMessage); // custom state to hold modal message
        const modal = new window.bootstrap.Modal(
          document.getElementById("inactiveModal")
        );
        modal.show();
      } else {
        // Handle other login errors
        setErrors({
          general: fieldErrors.account
            ? fieldErrors.account[0]
            : "Invalid username or password.",
          ...fieldErrors,
        });
        toast.error("Invalid username or password!", {
          position: "top-right",
          autoClose: 3000,
        });
      }
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div>
      <Helmet>
        <title>Login</title>
      </Helmet>
      <div
        className="modal fade"
        id="inactiveModal"
        tabIndex="-1"
        aria-labelledby="inactiveModalLabel"
        aria-hidden="true"
      >
        <div className="modal-dialog modal-dialog-centered">
          <div className="modal-content">
            <div className="modal-header">
              <h5 className="modal-title" id="inactiveModalLabel">
               Notify
              </h5>
              <button
                type="button"
                className="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
            </div>
            <div className="modal-body">{modalMessage}</div>
            <div className="modal-footer">
              <button
                type="button"
                className="btn btn-secondary"
                data-bs-dismiss="modal"
              >
                Confirm
              </button>
            </div>
          </div>
        </div>
      </div>

      <section className="login_registration">
        <div className="container">
          <div className="row">
            <div className="col-xl-4 col-md-6 m-auto">
              <div className="log_regi">
                <img
                  src="/fasttrading/images/logo.png"
                  className="img-fluid"
                  alt="Logo"
                />
                <h4>Login</h4>
                <form onSubmit={handleSubmit} className="log_regi_form">
                  <div className="form-group mb-2">
                    <label htmlFor="email">
                      Username <span className="text-danger">*</span>
                    </label>
                    <input
                      type="text"
                      placeholder="Username"
                      className="form-control"
                      value={username}
                      onChange={(e) => setUsername(e.target.value)}
                    />
                    {errors.username && (
                      <div className="error text-danger">{errors.username}</div>
                    )}
                  </div>

                  <div className="form-group mb-2">
                    <label htmlFor="password">
                      Password <span className="text-danger">*</span>
                    </label>
                    <input
                      type="password"
                      placeholder="Password"
                      className="form-control"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                    />
                    {errors.password && (
                      <div className="error text-danger">{errors.password}</div>
                    )}
                  </div>

                  {errors.general && (
                    <div className="error text-danger mb-2">
                      {errors.general}
                    </div>
                  )}

                  {/* Loading progress bar */}
                  {isLoading && (
                    <div className="progress-container">
                      <div className="progress-bar"></div>
                    </div>
                  )}

                  <button
                    type="submit"
                    className="btn_primary"
                    disabled={isLoading} // Disable button when loading
                  >
                    {isLoading ? "Loading..." : "Login"}{" "}
                    {/* Show loading text */}
                  </button>
                </form>
              </div>

              <Link to="/register" className="log_regi_link">
                Create a new account
              </Link>
              <div className="back-to-home">
                <button onClick={() => navigate("/")} className="btn_secondary">
                  Back to Home
                </button>
              </div>
              <Footer />
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default Login;
