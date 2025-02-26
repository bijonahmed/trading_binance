import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import AuthUser from "./AuthUser"; // Ensure correct import path

const AuthGuard = ({ children }) => {
  const navigate = useNavigate();
  const { token } = AuthUser();

  useEffect(() => {
    if (!token) {
      console.log("No token found. Redirecting to login...");
      navigate("/login");
    }
  }, [token, navigate]);

  return token ? children : null;
};

export default AuthGuard;
