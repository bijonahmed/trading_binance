<template>
    <title>Kyc Preview</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Kyc Preview</p>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <LazyNuxtLink to="/admin/dashboard">Home</LazyNuxtLink>
                                </li>
                                <li class="breadcrumb-item active">
                                    <LazyNuxtLink to="/usermanagement/kyc/kyclist">Back to List</LazyNuxtLink>
                                </li>
                            </ol>
                        </div>
                    </div>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid">

                    <div class="col-xl-12 mx-auto">
                        <div class="card border-top border-0 border-4 border-info">
                            <div class="card-body">
                                <div class="border p-4 rounded">
                                    <div class="card">

                                        <div class="row">
                                            <div class="col-md-12">


                                                <div class="container">
                                                    <div class="row">
                                                        <div v-for="item in dataList" :key="item.id"
                                                            class="col-md-3 col-12 kyc-item">
                                                            <div class="card p-3 shadow-sm">
                                                                <p><strong>User ID:</strong> {{ item.user_id }}</p>

                                                                <div v-if="item.passport">
                                                                    <p><strong>Passport:</strong></p>
                                                                    <img :src="item.passport" alt="Passport"
                                                                        class="img-fluid" />
                                                                </div>

                                                                <div v-if="item.dl_front">
                                                                    <p><strong>DL Front:</strong></p>
                                                                    <img :src="item.dl_front" alt="DL Front"
                                                                        class="img-fluid" />
                                                                </div>

                                                                <div v-if="item.dl_back">
                                                                    <p><strong>DL Back:</strong></p>
                                                                    <img :src="item.dl_back" alt="DL Back"
                                                                        class="img-fluid" />
                                                                </div>

                                                                <div v-if="item.frontFile_nid">
                                                                    <p><strong>NID Front:</strong></p>
                                                                    <img :src="item.frontFile_nid" alt="NID Front"
                                                                        class="img-fluid" />
                                                                </div>

                                                                <div v-if="item.backFile_nid">
                                                                    <p><strong>NID Back:</strong></p>
                                                                    <img :src="item.backFile_nid" alt="NID Back"
                                                                        class="img-fluid" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>

                                        </div>
                                    </div>

                                    <form @submit.prevent="saveData()" id="formrest" class="forms-sample"
                                        enctype="multipart/form-data">
                                        <div class="card card-primary card-outline card-tabs">
                                            <div class="card-header p-0 pt-1 border-bottom-0">
                                                <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" id="custom-tabs-three-home-tab"
                                                            data-toggle="pill" href="#custom-tabs-three-home" role="tab"
                                                            aria-controls="custom-tabs-three-home"
                                                            aria-selected="true">Update</a>
                                                    </li>

                                                </ul>
                                            </div>
                                            <div class="card-body">
                                                <div class="tab-content" id="custom-tabs-three-tabContent">
                                                    <div class="tab-pane fade active show" id="custom-tabs-three-home"
                                                        role="tabpanel" aria-labelledby="custom-tabs-three-home-tab">
                                                        <!-- General  {{ request.deposit_amount }}-->
                                                        <div class="row mb-3 required">
                                                            <label for="input-name-1"
                                                                class="col-sm-2 col-form-label required-label">Status</label>
                                                            <div class="col-sm-10">
                                                                <select v-model="request.status" class="form-control">
                                                                    <option value="0">Pending</option>
                                                                    <option value="1">Approved</option>
                                                                </select>
                                                                <span class="text-danger" v-if="errors.status">{{
                                                                    errors.status[0] }}</span>
                                                            </div>
                                                        </div>



                                                        <button type="submit" class="btn btn-success px-5 w-100"
                                                            @click="saveData" :disabled="isSubmitting">
                                                            <i class="bx bx-check-circle mr-1"></i>
                                                            {{ isSubmitting ? 'Updating...' : 'Update' }}
                                                        </button>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </form>





                                    <!-- END -->
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </section>
        </div>
    </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
const router = useRouter();
import axios from 'axios';
import swal from 'sweetalert2';
window.Swal = swal;

definePageMeta({
    middleware: 'is-logged-out',
})
const request = ref({
    id: '',
    depositID: '',
    deposit_amount: '',
    receivable_amount: '',
    gamePltformName: '',
    to_crypto_wallet_address: '',
    frm_wallet_address: '',
    trxId: '',
    currencyName: '',
    payment_method: '',
    approved_by: '',
    created_at: '',
    status: '',

});

const notifmsg = ref('');
const errors = ref({});
const dataList = ref({});


//alert("Your data has been successfully inserted.");
const Toast = Swal.mixin({
    toast: true,
    position: "top-end",
    showConfirmButton: false,
    timer: 5000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.onmouseenter = Swal.stopTimer;
        toast.onmouseleave = Swal.resumeTimer;
    }
});

const isSubmitting = ref(false);  // Add a reactive variable to track submission state

const saveData = () => {
  
    isSubmitting.value = true; // Disable button on click


    const formData = new FormData();
    const id = router.currentRoute.value.query.parameter;
    formData.append('id', id);
    formData.append('status', request.value.status);

    axios.post('/user/kycRequestApprovedUpdate', formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    })
        .then((res) => {

            success_noti();
            router.push({
                path: '/usermanagement/kyc/kyclist',
            });
        })
        .catch(error => {
            if (error.response && error.response.status === 422) {
                errors.value = error.response.data.errors;
            } else {
                console.error("An error occurred:", error);
            }
        })
        .finally(() => {
            isSubmitting.value = false; // Re-enable the button after request completion
        });
};


const formatDate = (dateString) => {
    const date = new Date(dateString);
    const day = date.getDate().toString().padStart(2, '0');
    const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const month = monthNames[date.getMonth()];
    const year = date.getFullYear();
    return `${day}-${month}-${year}`;
}


const getStatus = (status) => {
    let result = '';
    if (status === 0) {
        result = 'Pending';
    } else if (status === 1) {
        result = 'Has been approved';
    } else if (status === 2) {
        result = 'Has been rejected';
    }
    return result;
}

const productDetails = () => {
    const id = router.currentRoute.value.query.parameter;
    axios.get(`/user/checkkycuserrow/${id}`)
        .then(response => {
            dataList.value = response.data; // Update the reactive ref
        })
        .catch(error => {
            console.error("Error fetching KYC data:", error);
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
        title: "Has been successfully update Deposit."
    });
};
onMounted(() => {
    productDetails();
});
</script>


<style>
.kyc-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); /* 4 columns */
  gap: 20px;
}

.kyc-card {
  border: 1px solid #ddd;
  padding: 15px;
  text-align: center;
  border-radius: 8px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

.kyc-card img {
  max-width: 100%;
  height: auto;
  border-radius: 5px;
  margin-top: 10px;
}</style>