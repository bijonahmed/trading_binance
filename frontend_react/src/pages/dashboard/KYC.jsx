import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import Navbar from "../../components/Navbar";
import Footer from "../../components/Footer";
import Sidebar from "../../components/SidebarAuth";
import NavbarAuth from "../../components/NavbarAuth";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig"; // Ensure correct path
import QRCode from "qrcode";
import AuthGuard from "../../components/AuthGuard";
import AuthUser from "../../components/AuthUser";
import { useParams } from "react-router-dom";

const KYC = () => {
  const [hasRequested, setHasRequested] = useState(false);
  const { token, logout } = AuthUser();
  const [nationalCardStatus, setNationalCardStatus] = useState(null);
  const [drive_status, setDrivLienceStatus] = useState(null);
  const [errors, setErrors] = useState({});
  const [passport_status, setPassportStatus] = useState("");
  const [dlFrontPreview, setDlFrontPreview] = useState("");
  const [dlBackPreview, setDlBackPreview] = useState("");
  // States for files
  const [dlFrontFile, setDlFrontFile] = useState(null);
  const [dlBackFile, setDlBackFile] = useState(null);
  //previewImagePassport
  // State for preview and file storage
  const [passportPreview, setPassportPreview] = useState();
  const [passportFile, setPassportFile] = useState(null);
  // State to hold the image previews
  const [frontImage, setFrontImage] = useState();
  const [backImage, setBackImage] = useState("images/blank.png");
  // State to hold the image files
  const [frontFile, setFrontFile] = useState(null);
  const [backFile, setBackFile] = useState(null);
  // Function to preview the image
  const previewImageNationalIdCard = (e, setImage, setFile) => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => {
        setImage(reader.result); // Set the preview image
      };
      reader.readAsDataURL(file);
      setFile(file); // Store file for upload
    }
  };
  // Submit function to send data to server
  const handleSubmitNationalCard = async (e) => {
    e.preventDefault();

    if (!frontFile || !backFile) {
      //  alert("Please upload both front and back images.");
      Swal.fire({
        icon: "error",
        title: "Validation Error",
        html: `Please upload both front and back images.`,
      });
      return;
      return;
    }
    try {
      const formData = new FormData();
      formData.append("frontFile_nid", frontFile);
      formData.append("backFile_nid", backFile);
      const response = await axios.post(
        "/user/upload-kyc-national_id_card",
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );
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
        title:
          "Your KYC request has been successfully sent. We will review your documents and update you shortly.",
      });
      closeModal();
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

  // Function to preview image
  const previewImagePassport = (event) => {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => setPassportPreview(reader.result);
      reader.readAsDataURL(file);
      setPassportFile(file);
    }
  };

  // Function to preview image before upload
  const previewImage = (event, setPreview, setFile) => {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => {
        setPreview(reader.result); // Show preview
      };
      reader.readAsDataURL(file);
      setFile(file); // Store file for form submission
    }
  };

  const handleSubmitPassport = async (e) => {
    e.preventDefault();
    try {
      if (!passportFile) {
        Swal.fire({
          icon: "error",
          title: "Validation Error",
          html: `
            <div style="text-align: left;">
              ${
                !dlFrontFile
                  ? "<p>⚠️ Passport front image is required.</p>"
                  : ""
              }
            </div>
          `,
        });
        return;
      }
      const formData = new FormData();
      formData.append("passportFile", passportFile);
      const response = await axios.post("/user/upload-kyc-passport", formData, {
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
        title:
          "Your KYC request has been successfully sent. We will review your documents and update you shortly.",
      });
      $("#passport_mdal").modal("hide");
      //console.log(response.data.message);
      //navigate("/user/profile");
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

  const handleSubmitDriveLice = async (e) => {
    e.preventDefault();
    try {
      if (!dlFrontFile || !dlBackFile) {
        Swal.fire({
          icon: "error",
          title: "Validation Error",
          html: `
            <div style="text-align: left;">
              ${!dlFrontFile ? "<p>⚠️ Front image is required.</p>" : ""}
              ${!dlBackFile ? "<p>⚠️ Back image is required.</p>" : ""}
            </div>
          `,
        });
        return;
      }

      const formData = new FormData();
      formData.append("dl_front", dlFrontFile);
      formData.append("dl_back", dlBackFile);

      const response = await axios.post(
        "/user/upload-kyc-driveLicence",
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );
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
        title:
          "Your KYC request has been successfully sent. We will review your documents and update you shortly.",
      });
      $("#dl_mdal").modal("hide");
      //console.log(response.data.message);
      //navigate("/user/profile");
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

  const [showModal, setShowModal] = useState(false);
  // Function to open the modal
  const showNidModal = () => setShowModal(true);
  const closeModal = () => setShowModal(false);

  const checkNationalCard = async () => {
    try {
      const response = await axios.get(`/user/checkNationalCard`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        }, // Removed the extra comma here
      });
      const idCard_status = response.data.idCard_status;
      const idCardfront_img = response.data.idCardfront_img;
      const idCardback_img = response.data.idCardback_img;
      //console.log("====" + passStatus);
      setNationalCardStatus(idCard_status);
       setFrontImage(idCardfront_img);
       setBackImage(idCardback_img);
    } catch (error) {
      console.error("Error Data:", error);
    }
  };

  const checkDrivLience = async () => {
    try {
      const response = await axios.get(`/user/checkDriveLince`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        }, // Removed the extra comma here
      });
      const dl_status = response.data.dl_status;
      const dlFrontImg = response.data.dl_front_img;
      const dlBackImg = response.data.dl_back_img;
      //console.log("====" + passStatus);
      setDrivLienceStatus(dl_status);
      setDlFrontPreview(dlFrontImg);
      setDlBackPreview(dlBackImg);
    } catch (error) {
      console.error("Error Data:", error);
    }
  };

  const checkPassport = async () => {
    try {
      const response = await axios.get(`/user/checkPassport`, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        }, // Removed the extra comma here
      });
      const passStatus = response.data.passport_status;
      const passImg = response.data.passport_img;
      //console.log("====" + passStatus);
      setPassportStatus(passStatus);
      setPassportPreview(passImg);
    } catch (error) {
      console.error("Error Data:", error);
    }
  };

  useEffect(() => {
    checkNationalCard();
    checkDrivLience();
    checkPassport();
  }, []);

  return (
    <>
      <Helmet>
        <title>KYC</title>
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
          {/* Start */}
          <div className="dashboard_content">
            <div className="row">
              <div className="col-md-12 m-auto">
                <div className="page_title">
                  <a
                    href="#"
                    className="btn_back"
                    click="history.back(); return false;"
                  >
                    <i className="fa-solid fa-arrow-left" />
                  </a>
                  <div className="d-flex justify-content-between w-100 align-items-end">
                    <h4>KYC Varification</h4>
                  </div>
                </div>
                <div className="kyc_section">
                  <div className="kyc_container">
                    <div className="form_group kyc_">
                      <h4>ID Card</h4>
                      <button
                        type="button"
                        onClick={showNidModal} // Open modal on click
                      >
                        <img
                          src="/fasttrading/images/id.png"
                          alt="Front Preview"
                          className="img-fluid preview-img"
                          id="front-preview"
                        />
                      </button>
                    </div>

                    <div className="form_group kyc_">
                      <h4>Passport</h4>
                      <button
                        type="button"
                        data-bs-toggle="modal"
                        data-bs-target="#passport_mdal"
                      >
                        <img
                          src="/fasttrading/images/pp.png"
                          alt="Front Preview"
                          className="img-fluid  preview-img"
                          id="front-preview"
                        />
                      </button>
                    </div>
                    <div className="form_group kyc_">
                      <h4>Driver's License</h4>
                      <button
                        type="button"
                        data-bs-toggle="modal"
                        data-bs-target="#dl_mdal"
                      >
                        <img
                          src="/fasttrading/images/dl.png"
                          alt="Front Preview"
                          className="img-fluid preview-img"
                          id="front-preview"
                        />
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* END */}

          {/* Start modal */}
          <div>
            {/* Nid modal  */}
            {/* Modal */}
            {showModal && (
              <div
                className="modal fade show"
                tabIndex={-1}
                id="nationalIdCardmodal"
                aria-labelledby="id_mdalLabel"
                aria-hidden="true"
                style={{ display: "block" }} // Modal is visible
              >
                <div className="modal-dialog modal-dialog-centered">
                  <div className="modal-content rounded-0">
                    <div className="modal-header py-0">
                      <h5 className="modal-title fs-6" id="id_mdalLabel">
                        ID Card
                      </h5>
                      <button
                        type="button"
                        className="btn_close text-white"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                        onClick={closeModal}
                      >
                        <i className="fas fa-times" />
                      </button>
                    </div>
                    <div className="modal-body">
                      <form
                        onSubmit={handleSubmitNationalCard}
                        className="kyc_form"
                      >
                        <div className="form_group kyc_ kyc_dl">
                          <h6>Front</h6>
                          <label htmlFor="idfront">
                            <i className="fa-solid fa-plus" />
                            <img
                              src={frontImage}
                              className="img-fluid demo_image"
                              id="idfront-preview"
                              alt="Front Preview"
                            />
                          </label>
                          <input
                            type="file"
                            hidden
                            id="idfront"
                            accept="image/*"
                            className="img-fluid"
                            onChange={(e) =>
                              previewImageNationalIdCard(
                                e,
                                setFrontImage,
                                setFrontFile
                              )
                            }
                          />
                        </div>

                        <div className="form_group kyc_ kyc_dl">
                          <h6>Back</h6>
                          <label htmlFor="idback">
                            <i className="fa-solid fa-plus" />
                            <img
                              src={backImage}
                              className="img-fluid demo_image"
                              id="idback-preview"
                              alt="Back Preview"
                            />
                          </label>
                          <input
                            type="file"
                            hidden
                            id="idback"
                            accept="image/*"
                            className="img-fluid"
                            onChange={(e) =>
                              previewImageNationalIdCard(
                                e,
                                setBackImage,
                                setBackFile
                              )
                            }
                          />
                        </div>

                        {nationalCardStatus === 1 ? (
                          <>
                            <p className="text-white text-center">
                              Your  ID Card has been submitted.
                            </p>
                          </>
                        ) : (
                          <>
                            <button
                              type="submit"
                              className="btn_primary style-1 border-0 py-2 w-100"
                            >
                              Upload
                            </button>
                          </>
                        )}
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {/* Passport modal  */}
            <div
              className="modal fade"
              id="passport_mdal"
              tabIndex={-1}
              aria-labelledby="passport_mdalLabel"
              aria-hidden="true"
            >
              <div className="modal-dialog modal-dialog-centered">
                <div className="modal-content rounded-0">
                  <div className="modal-header py-0">
                    <div className="w-10" />
                    <h5 className="modal-title fs-6" id="passport_mdalLabel">
                      Passport
                    </h5>
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
                    <form onSubmit={handleSubmitPassport} className="kyc_form">
                      {/* Passport Image Upload */}
                      <div className="form_group kyc_ kyc_dl text-center">
                        <label htmlFor="passport">
                          <i className="fa-solid fa-plus" />
                          <img
                            src={passportPreview}
                            className="img-fluid demo_image"
                            alt="Passport Preview"
                          />
                        </label>
                        <input
                          type="file"
                          id="passport"
                          hidden
                          accept="image/*"
                          onChange={previewImagePassport}
                        />
                      </div>

                      {passport_status === 1 ? (
                        <>
                          <p className="text-white text-center">
                            Your passport has been submitted.
                          </p>
                        </>
                      ) : (
                        <>
                          <button
                            type="submit"
                            className="btn_primary style-1 border-0 py-2 w-100"
                          >
                            Upload
                          </button>
                        </>
                      )}
                    </form>
                  </div>
                </div>
              </div>
            </div>
            {/* Dl modal  */}
            <div
              className="modal fade"
              id="dl_mdal"
              tabIndex={-1}
              aria-labelledby="dl_mdalLabel"
              aria-hidden="true"
            >
              <div className="modal-dialog modal-dialog-centered">
                <div className="modal-content rounded-0">
                  <div className="modal-header py-0">
                    <div className="w-10" />
                    <h5 className="modal-title fs-6" id="dl_mdalLabel">
                      Driver's License
                    </h5>
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
                    <form onSubmit={handleSubmitDriveLice} className="kyc_form">
                      {/* Front Image Upload */}
                      <div className="form_group kyc_ kyc_dl text-center">
                        <h6>Front</h6>
                        <label htmlFor="dlfront">
                          <i className="fa-solid fa-plus" />
                          <img
                            src={dlFrontPreview}
                            className="img-fluid demo_image"
                            alt="Front Preview"
                          />
                        </label>
                        <input
                          type="file"
                          id="dlfront"
                          hidden
                          accept="image/*"
                          onChange={(e) =>
                            previewImage(e, setDlFrontPreview, setDlFrontFile)
                          }
                        />
                      </div>

                      {/* Back Image Upload */}
                      <div className="form_group kyc_ kyc_dl text-center">
                        <h6>Back</h6>
                        <label htmlFor="dlback">
                          <i className="fa-solid fa-plus" />
                          <img
                            src={dlBackPreview}
                            className="img-fluid demo_image"
                            alt="Back Preview"
                          />
                        </label>
                        <input
                          type="file"
                          id="dlback"
                          hidden
                          accept="image/*"
                          onChange={(e) =>
                            previewImage(e, setDlBackPreview, setDlBackFile)
                          }
                        />
                      </div>

                      {drive_status === 1 ? (
                        <>
                          <p className="text-white text-center">
                            Your Driver's License has been submitted.
                          </p>
                        </>
                      ) : (
                        <>
                          <button
                            type="submit"
                            className="btn_primary style-1 border-0 py-2 w-100"
                          >
                            Upload
                          </button>
                        </>
                      )}
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* END Modal */}
        </div>
      </div>
    </>
  );
};

export default KYC;
