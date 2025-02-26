<template>
  <title>Add Post</title>
  <div>
    <div class="content-wrapper">
      <section class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <p>Add Post</p>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <LazyNuxtLink to="/admin/dashboard">Home</LazyNuxtLink>
                </li>
                <li class="breadcrumb-item active">
                  <LazyNuxtLink to="/post/shortvideo/list">Back to List</LazyNuxtLink>
                </li>
              </ol>
            </div>
          </div>
        </div>
      </section>

      <!-- <button @click="pageRedirect()">Pages</button> -->
      <section class="content">
        <div class="container-fluid">
          <!-- Start -->
          <div class="card border-top border-0 border-4 border-info">
            <div class="border p-4 rounded">
              <form @submit.prevent="saveData()" id="formrest" class="forms-sample" enctype="multipart/form-data">
                <div class="card card-primary card-outline card-tabs">
                  <div class="card-header p-0 pt-1 border-bottom-0">
                    <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                      <li class="nav-item">
                        <a class="nav-link active" id="custom-tabs-three-home-tab" data-toggle="pill"
                          href="#custom-tabs-three-home" role="tab" aria-controls="custom-tabs-three-home"
                          aria-selected="true">General</a>
                      </li>

                    </ul>
                  </div>
                  <div class="card-body">
                    <div class="tab-content" id="custom-tabs-three-tabContent">
                      <div class="tab-pane fade active show" id="custom-tabs-three-home" role="tabpanel"
                        aria-labelledby="custom-tabs-three-home-tab">
                        <!-- General  -->

                        <div class="alert alert-info" bis_skin_checked="1">
                          <i class="fas fa-info-circle"></i>Thumbnail
                        </div>
                        <div class="row mb-3">
                          <label for="input-meta-description-1" class="col-sm-2 col-form-label">Thumbnail Videos
                          </label>
                          <div class="col-sm-10">
                            <input type="file" class="form-control" id="fileInput" accept="video/mp4"
                              @change="handleFileChange" />
                            <video v-if="previewUrl" :src="previewUrl" controls class="video-fluid"
                              @error="handleVideoError">
                              Your browser does not support the video tag.
                            </video>
                            <p v-else-if="errorMessage" class="error-message">{{ errorMessage }}</p>
                          </div>
                        </div>

                        <button type="submit" class="btn btn-success px-5 w-100">
                          <i class="bx bx-check-circle mr-1"></i> Save & Next
                        </button>

                      </div>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
        <!-- END -->
      </section>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import axios from 'axios';
import swal from 'sweetalert2';
window.Swal = swal;
import 'summernote/dist/summernote-bs4.js';
import 'summernote/dist/summernote-bs4.css';
const router = useRouter()

const insertdata = reactive({
  name: '',
  categoryId: '',
  question: '',
  answer: '',
  images: '',
  status: 1,
});
// Define a ref to store the HTML content of the editor
const categoryId = ref(null);
const descriptionShort = ref('');
const descriptionFull = ref('');
const previewUrl = ref(null);
const images = ref([]);
const postCat = ref([]);

const file = ref(null);
const files = ref(null);
const errors = ref({});


// Initialize Summernote editor

definePageMeta({
  middleware: 'is-logged-out',
})

onMounted(() => {

});

// Define your methods



const errorMessage = ref("");

const handleFileChange = (event) => {
  file.value = event.target.files[0]; // Get the selected file
  console.log("File selected:", file.value);

  if (file.value && file.value.type === 'video/mp4') {
    // Create a URL for the video preview
    previewUrl.value = URL.createObjectURL(file.value);
    console.log("File selected:", file.value);
  } else {
    previewUrl.value = null; // Reset preview if the file is not an mp4
    console.error("Invalid file type. Only MP4 videos are allowed.");
  }

};


const handleVideoError = () => {
  errorMessage.value = "Failed to load the video. The file may be corrupted or unsupported.";
  previewUrl.value = null;
};


const saveData = () => {

  // Check if a file is selected
  if (!file.value) {
    console.error("No file selected");
    return;
  }

  // Create a new FormData instance
  const formData = new FormData();
  formData.append('files', file.value); // Correctly append the file
  console.log("FormData contents:", formData);

  // Make the POST request using Axios
  axios
    .post('/post/saveShortVideo', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
    .then((res) => {
      console.log("Response from server:", res.data);

      // Reset the form if applicable (using jQuery)
      $('#formrest')[0]?.reset();

      // Show success notification
      success_noti();

      // Retrieve product_id from the response
      const shortvideoId = res.data.shortvideoId;

      // Redirect to the preview page using Vue Router
      router.push({
        path: '/post/shortvideo/add',
      });


    })
    .catch((error) => {
      if (error.response && error.response.status === 422) {
        // Validation errors
        errors.value = error.response.data.errors;
      } else {
        // Handle other types of errors
        console.error("An error occurred:", error);
      }
    });
};

const success_noti = () => {
  //alert("Your data has been successfully inserted.");
  const Toast = Swal.mixin({
    toast: true,
    position: "top-end",
    showConfirmButton: false,
    timer: 1000,
    timerProgressBar: true,
    didOpen: (toast) => {
      toast.onmouseenter = Swal.stopTimer;
      toast.onmouseleave = Swal.resumeTimer;
    }
  });
  Toast.fire({
    icon: "success",
    title: "Your data has been successfully inserted."
  });
};

</script>

<style scoped>
.video-fluid {
  width: 300px;
  /* Set the desired width */
  height: 450px;
  /* Set the desired height */
  object-fit: cover;
  /* Ensure the video content fits neatly */
  border: 1px solid #ccc;
  /* Optional: Add a border for better visibility */
  border-radius: 8px;
  /* Optional: Add rounded corners */
}

.required-label::after {
  content: "\2605";
  color: red;
  margin-right: 4px;
}

/* CSS */
ol,
ul {
  padding-left: 0rem;
}

ul {
  list-style: none;
}

.bgColor {
  background-color: #c8c8c8;
  padding: 1px;
  border-radius: 2px;
}

.img-fluid {
  width: 300px;
  height: 150px;
}

.img-fluids {
  margin-top: 10px;
  width: 300px;
  height: 300px;
}

/* for checkbox */
.multiselect {
  position: relative;
  font-family: Arial, sans-serif;
  width: 100%;
}

.select-box {
  border: 1px solid #ccc;
  padding: 8px;
  cursor: pointer;
  background-color: #fff;
}

.dropdown {
  border: 1px solid #ccc;
  border-top: none;
  max-height: 400px;
  overflow-y: auto;
  position: absolute;
  top: 100%;
  width: 100%;
  background-color: #fff;
  z-index: 1;
}

label {
  display: block;
  padding: 5px;
}

input[type="checkbox"] {
  margin-right: 8px;
}

.widthtxtbox {
  width: 50px;
}
</style>
