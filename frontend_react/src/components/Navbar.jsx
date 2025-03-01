import React, { useEffect } from "react";
import { useNavigate, Link } from "react-router-dom";
import AuthUser from "../components/AuthUser";

const Navbar = () => {
  const navigate = useNavigate();
  const { token, logout } = AuthUser();
  // Function to remove inline styles from body
  const removeBodyStyles = () => {
    document.body.removeAttribute("style");
  };

  const logoutUser = async () => {
    logout();
    localStorage.removeItem("token");
    setTimeout(() => {
      navigate("/login");
    }, 100); // Small delay to allow state update
  };



  useEffect(() => {
    // Attach event listener to all nav-links
    const navLinks = document.querySelectorAll(".nav-link");
    navLinks.forEach((link) => {
      link.addEventListener("click", removeBodyStyles);
    });
    // Cleanup event listeners when the component unmounts
    return () => {
      navLinks.forEach((link) => {
        link.removeEventListener("click", removeBodyStyles);
      });
    };
  }, []);

  return (
    <div className="main_navbar">
      <nav className="navbar navbar-expand-lg ">
        <div className="container-fluid">
          <Link className="navbar-brand" to="/">
            <img
              src="/fasttrading/images/logo.png"
              alt="img"
              className="img-fluid"
            />
          </Link>
          {/* =========== */}
          <div
            className="offcanvas offcanvas-start "
            data-bs-backdrop="static"
            tabIndex={-1}
            id="staticBackdrop"
            aria-labelledby="staticBackdropLabel"
          >
            <div className="offcanvas-header text-end">
              <button
                type="button"
                className="btn_close"
                data-bs-dismiss="offcanvas"
                aria-label="Close"
              >
                <i className="fa-solid fa-x" />
              </button>
            </div>
            <div className="offcanvas-body">
              <div className="">
                <div className="d-flex align-items-center w-100 justify-content-between">
                  <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                    <li className="nav-item">
                      <Link
                        className="nav-link"
                        aria-current="page"
                        to="/market"
                      >
                        Markets
                      </Link>
                    </li>
                    <li className="nav-item">
                      <Link className="nav-link" to="/dashboard/trade-history">
                        Trade
                      </Link>
                    </li>

                    {token ? (
                      <>
                      <li className="nav-item">
                      <Link
                        className="nav-link"
                        aria-current="page"
                        to="/market"
                      >
                        Markets
                      </Link>
                    </li>
                        <li className="nav-item">
                          <Link className="nav-link" to="/dashboard/profile">
                            Profile
                          </Link>
                        </li>
                        <li className="nav-item">
                          <Link className="nav-link" to="/dashboard/wallet">
                            Wallet
                          </Link>
                        </li>
                        <li className="nav-item">
                          <Link className="nav-link" to="/dashboard/deposit">
                            Deposit
                          </Link>
                        </li>
                        <li className="nav-item">
                          <Link className="nav-link" to="/dashboard/withdraw">
                            Withdraw
                          </Link>
                        </li>
                        <li className="nav-item">
                          <Link className="nav-link" to="/dashboard/payment">
                            Payment Method
                          </Link>
                        </li>
                        <li className="nav-item">
                          <Link
                            className="nav-link"
                            to="/dashboard/trade-history"
                          >
                            Trade History
                          </Link>
                        </li>
                        <li className="nav-item">
                          <Link className="nav-link" to="/dashboard/kyc">
                            KYC Verification
                          </Link>
                        </li>
                      </>
                    ) : null}
                  </ul>
                </div>
              </div>

              {/* mobile login register  */}

              <ul className="navbar-nav ms-auto mobile_ group_btns mb-2 mb-lg-0  d-sm-none ">
                {token ? (
                  <>
                    <li className="nav-item w-50">
                      <Link
                        className="nav-link btn_login w-100"
                        to="/dashboard/profile"
                      >
                        Profile
                      </Link>
                    </li>
                    <li className="nav-item w-50">
                      <Link
                        className="nav-link btn_signup w-100"
                        onClick={logoutUser}
                      >
                        Logout
                      </Link>
                    </li>
                  </>
                ) : (
                  <>
                    <li className="nav-item w-50">
                      <Link className="nav-link btn_login w-100" to="/login">
                        Login
                      </Link>
                    </li>
                    <li className="nav-item w-50">
                      <Link
                        className="nav-link btn_signup w-100"
                        to="/register"
                      >
                        Sign Up
                      </Link>
                    </li>
                  </>
                )}
              </ul>
            </div>
          </div>
          <div className="d-flex">
            <div className="d-none d-sm-flex">
              {/* desktop login register btn_login
               */}
              <ul className="navbar-nav ms-auto group_btns mb-2 mb-lg-0 d-none d-lg-flex">
                {token ? (
                  <>
                    <li className="nav-item">
                      <Link className="nav-link " to="/dashboard/profile">
                        My Profile
                      </Link>
                    </li>
                    <li className="nav-item" onClick={logoutUser}>
                      <Link className="nav-link " to="#">
                        Logout
                      </Link>
                    </li>
                  </>
                ) : (
                  <>
                    <li className="nav-item">
                      <Link className="nav-link " to="/login">
                        Login
                      </Link>
                    </li>
                    <li className="nav-item">
                      <Link className="nav-link btn_signup" to="/register">
                        Sign Up
                      </Link>
                    </li>
                  </>
                )}
              </ul>
            </div>

            {token ? (
              <>
                <ul className="navbar-nav">
                  <li className="nav-item dropdown profile_pic">
                    <a
                      className="nav-link  dropdown-toggle"
                      href="market.html"
                      role="button"
                      data-bs-toggle="dropdown"
                      aria-expanded="false"
                    >
                      <i className="fa-solid fa-user" />
                      <div>
                        <h4>User</h4>
                      </div>
                    </a>
                    <ul className="dropdown-menu">
                      <li>
                        <Link to="/dashboard/profile" className="dropdown-item">
                          <i className="fa-solid fa-user" />
                          Profile
                        </Link>
                      </li>
                      <li>
                        <Link to="/dashboard/wallet" className="dropdown-item">
                          <i className="fa-solid fa-wallet" />
                          Wallet
                        </Link>
                      </li>
                      <li>
                        <button className="dropdown-item" onClick={logoutUser}>
                          <i className="fa-solid fa-right-from-bracket" />
                          &nbsp; Logout
                        </button>
                      </li>
                    </ul>
                  </li>
                </ul>
              </>
            ) : null}

            <button
              className="btn btn_menu navbar-toggler text-white"
              type="button"
              data-bs-toggle="offcanvas"
              data-bs-target="#staticBackdrop"
              aria-controls="staticBackdrop"
            >
              <i className="fa-solid fa-bars" />
            </button>
          </div>
        </div>
      </nav>
    </div>
  );
};

export default Navbar;
