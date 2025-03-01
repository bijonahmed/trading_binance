import React, { useState, useEffect } from "react";
import axios from "/config/axiosConfig";
import { useNavigate } from "react-router-dom";
import { Helmet } from "react-helmet";
import { Link } from "react-router-dom";
import "react-toastify/dist/ReactToastify.css";
import AuthUser from "../components/AuthUser";


const Register = () => {
  const navigate = useNavigate();
  const [errors, setErrors] = useState({}); // Define errors state
  const { http, setToken } = AuthUser();
  const [formData, setFormData] = useState({
    name: "",
    username: "",
    inviteCode: "",
    password: "",
    email:"",
    password_confirmation: "",
    agreeTerms: false,
  });

  // Handle input change
  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData({
      ...formData,
      [name]: type === "checkbox" ? checked : value,
    });
  };

  // **Validation function**
  const validate = () => {
    let errors = {};
    if (!formData.name) errors.name = "Name is required.";
    if (!formData.email) errors.email = "Email is required.";

    if (!formData.inviteCode) errors.inviteCode = "Invite code is required.";

    if (!formData.username) {
      errors.username = "Username is required.";
    }

    if (!formData.password) {
      errors.password = "Password is required.";
    } else if (formData.password.length < 6) {
      errors.password = "Password must be at least 6 characters.";
    }
  
    if (!formData.password_confirmation) {
      errors.password_confirmation = "Confirm password is required.";
    } else if (formData.password !== formData.password_confirmation) {
      errors.password_confirmation = "Passwords do not match.";
    }
  

    if (!formData.agreeTerms) {
      errors.agreeTerms = "You must agree to the terms.";
    }

    setErrors(errors);
    return Object.keys(errors).length === 0;
  };

  // **Handle form submission**
  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!validate()) return; // Stop if validation fails
    try {
      const response = await http.post("/auth/register", formData);
      setToken(response.data.user, response.data.access_token);
      $.notify("Successfully register. Please Login", "success");
      setTimeout(() => navigate("/login"), 3000);
    } catch (error) {
      console.error("Registration error:", error); // Log full error
      if (error.response) {
        console.error("Error response data:", error.response.data);
        if (error.response.data.errors) {
          setErrors(error.response.data.errors);
        } else {
          toast.error(error.response.data.message || "Something went wrong!");
        }
      } else {
        toast.error("Network error. Please try again.");
      }
    }
    
  };


  return (
    <div>
      <Helmet>
        <title>Register</title>
      </Helmet>

      <section className="login_registration">
        <div className="container">
          <div className="row">
            <div className="col-xl-4 col-md-6 m-auto">
              <div className="log_regi">
                <img src="/fasttrading/images/logo.png" className="img-fluid" />
                <h4>Welcome to First Trading</h4>

                <form onSubmit={handleSubmit} className="log_regi_form">
                  <div className="form-group mb-2">
                    <label htmlFor="name">
                      Name<span className="text-danger">*</span>
                    </label>
                    <input
                      type="text"
                      name="name"
                      placeholder="Name"
                      className="form-control"
                      value={formData.name}
                      onChange={handleChange}
                    />
                    {errors.name && (
                      <div className="error" style={{ color: "red" }}>
                        {errors.name}
                      </div>
                    )}
                  </div>


                  <div className="form-group mb-2">
                    <label htmlFor="email">
                      Email<span className="text-danger">*</span>
                    </label>
                    <input
                      type="text"
                      name="email"
                      placeholder="Email"
                      className="form-control"
                      value={formData.email}
                      onChange={handleChange}
                    />
                    {errors.email && (
                      <div className="error" style={{ color: "red" }}>
                        {errors.email}
                      </div>
                    )}
                  </div>

                  <div className="form-group mb-2">
                    <label htmlFor="username">
                      Username<span className="text-danger">*</span>
                    </label>
                    <input
                      type="text"
                      name="username"
                      placeholder="Username"
                      className="form-control"
                      value={formData.username}
                      onChange={handleChange}
                    />
                    {errors.username && (
                      <div className="error" style={{ color: "red" }}>
                        {errors.username}
                      </div>
                    )}
                  </div>

                  <div className="form-group mb-2">
                    <label htmlFor="inviteCode">
                      Invite Code<span className="text-danger">*</span>
                    </label>
                    <input
                      type="text"
                      name="inviteCode"
                      placeholder="Invite Code"
                      className="form-control"
                      value={formData.inviteCode}
                      onChange={handleChange}
                    />
                    {errors.inviteCode && (
                      <div className="error" style={{ color: "red" }}>
                        {errors.inviteCode}
                      </div>
                    )}
                  </div>

                  <div className="form-group mb-2">
                    <label htmlFor="password">
                      Password <span className="text-danger">*</span>
                    </label>
                    <input
                      type="password"
                      name="password"
                      placeholder="Password"
                      className="form-control"
                      value={formData.password}
                      onChange={handleChange}
                    />
                    {errors.password && (
                      <div className="error" style={{ color: "red" }}>
                        {errors.password}
                      </div>
                    )}
                  </div>

                  <div className="form-group mb-2">
                    <label htmlFor="password_confirmation">
                      Confirm Password <span className="text-danger">*</span>
                    </label>
                    <input
                      type="password"
                      name="password_confirmation"
                      placeholder="Confirm Password"
                      className="form-control"
                      value={formData.password_confirmation}
                      onChange={handleChange}
                    />
                    {errors.password_confirmation && (
                      <div className="error" style={{ color: "red" }}>
                        {errors.password_confirmation}
                      </div>
                    )}
                  </div>

                  <div className="form-group d-flex align-items-start">
                    <input
                      type="checkbox"
                      name="agreeTerms"
                      id="checkbox"
                      className="mt-1 me-2"
                      checked={formData.agreeTerms}
                      onChange={handleChange}
                    />
                    <label htmlFor="checkbox">
                      By creating an account, I agree to Binance's Terms of
                      Service and Privacy Policy.
                    </label>
                    
                  </div>
                  {errors.agreeTerms && (
                      <div className="error" style={{ color: "red" }}>
                        {errors.agreeTerms}
                      </div>
                    )}

                  <button type="submit" className="btn_primary">
                    Register
                  </button>
                </form>
              </div>
              <div className="back-to-home">
                <button onClick={() => navigate("/")} className="btn_secondary">
                  Back to Home
                </button>
              </div>
              <Link to="/login" className="log_regi_link">
                Already have a account?
              </Link>
             
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default Register;
