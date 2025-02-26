import React, { useState } from "react";
import { AdvancedVideo } from "@cloudinary/react";
import { Cloudinary } from "@cloudinary/url-gen";
import { quality, format } from "@cloudinary/url-gen/actions/delivery";

const VideoPlaylist = () => {
  // Initialize Cloudinary instance
  const cld = new Cloudinary({
    cloud: {
      cloudName: "dkiodlhwb", // Replace with your Cloudinary cloud name
    },
  });

  // Example video IDs (replace with your actual public IDs)
  const videoIds = [
    "0YSgsE86eGPWEavSitpF_ipiz3h",
    "0TKNHlWapIagu6GLLa9O_vhkzix",
    "0PamOAsRpHKAGav31XEB_fddtod",
    "2lkuukbGdoJQstVdVTUX_o1a8cr",
    "2J1QnlYl7pEM6EtjwRp6_vtq8ta",
    "1tKOthK9b7U5ZhQ3evoB_k3j4jk",
    "1Or2ks1GASRN02JDwcxn_wnaqvd",
    "0MEP03VtZ6tVkbr5rzM5_itljeo",
    "0Ze5Xs3NBBCsbCDE024j_ml9yim",
  ];

  // State to keep track of the current video index
  const [currentIndex, setCurrentIndex] = useState(0);

  // Create Cloudinary video object for the current video
  const cldVid = cld
    .video(videoIds[currentIndex])
    .delivery(quality("auto"))
    .delivery(format("auto"));

  // Function to handle video changes
  const changeVideo = (direction) => {
    setCurrentIndex((prevIndex) => {
      if (direction === "next") {
        return (prevIndex + 1) % videoIds.length; // Loop to the start
      } else if (direction === "prev") {
        return (prevIndex - 1 + videoIds.length) % videoIds.length; // Loop to the end
      }
      return prevIndex;
    });
  };

  return (
    <div className="video-playlist">
      <div className="video-container" style={{ maxWidth: "800px", margin: "0 auto" }}>
        <AdvancedVideo
          cldVid={cldVid}
          controls
          autoPlay
          loop
          style={{ width: "100%", maxHeight: "500px", objectFit: "cover" }}
        />
      </div>

      <div className="playlist-controls" style={{ textAlign: "center", marginTop: "20px" }}>
        <button onClick={() => changeVideo("prev")}>Previous</button>
        <span style={{ margin: "0 15px" }}>Video {currentIndex + 1} of {videoIds.length}</span>
        <button onClick={() => changeVideo("next")}>Next</button>
      </div>
    </div>
  );
};

export default VideoPlaylist;
