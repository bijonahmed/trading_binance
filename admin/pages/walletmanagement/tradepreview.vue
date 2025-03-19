<template>
    <title>Trade Preview</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Trade Preview</p>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <LazyNuxtLink to="/admin/dashboard">Home</LazyNuxtLink>
                                </li>
                                <li class="breadcrumb-item active">
                                    <LazyNuxtLink to="/walletmanagement/trade-request-management">Back to List
                                    </LazyNuxtLink>
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
                                                <table class="table table-bordered w-100">
                                                    <tr>
                                                        <td>Request By</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.name }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td width="40%">OrderID</td>
                                                        <td width="1%"><strong>:</strong></td>
                                                        <td width="50%">{{ request.tradeID }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td width="40%">Perp Cross</td>
                                                        <td width="1%"><strong>:</strong></td>
                                                        <td width="50%">{{ request.selectedCurrency }}USDT</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Type</td>
                                                        <td><strong>:</strong></td>
                                                        <td>
                                                            <span
                                                                :class="request.action_type === 'LONG' ? 'badge bg-success' : 'badge bg-danger'">
                                                                {{ request.action_type }}
                                                            </span>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>Amount(USDT)</td>
                                                        <td><strong>:</strong></td>
                                                        <td>$ {{ request.trade_amount }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Entry Price</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.market_price }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Open Time</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ formatDate(request.start_datetime) }}</td>
                                                        <!-- <td>{{ formatDate(request.created_at) }}</td> -->
                                                    </tr>

                                                    <tr>
                                                        <td>Close Price</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.close_price || '0.00' }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Close</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.end_datetime }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Fee</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.fee }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Closing PNL</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.closingPNL }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Action</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.action }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Status</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ getStatus(request.status) }}</td>
                                                    </tr>


                                                </table>

                                                <!-- END Bank -->

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
                                                                class="col-sm-2 col-form-label required-label">Market Price</label>
                                                            <div class="col-sm-10">
                                                                <input type="text" v-model="request.market_price"
                                                                    autofocus class="form-control" />
                                                                <span class="text-danger" v-if="errors.market_price">{{
                                                                    errors.market_price[0] }}</span>
                                                            </div>
                                                        </div>




                                                        <div class="row mb-3 required">
                                                            <label for="input-name-1"
                                                                class="col-sm-2 col-form-label required-label">Close
                                                                Price</label>
                                                            <div class="col-sm-10">
                                                                <input type="text" v-model="request.close_price"
                                                                    autofocus class="form-control" />
                                                                <span class="text-danger" v-if="errors.close_price">{{
                                                                    errors.close_price[0] }}</span>
                                                            </div>
                                                        </div>

                                                        <button type="submit" class="btn btn-success px-5 w-100">
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
    tradeID: '',
    user_id: '',
    name: '',
    email: '',
    username: '',
    market_price: '',
    trade_amount: '',
    selected_duration: '',
    selected_percentage: '',
    percentage_result: '',
    close_price: '',
    action_type: '',
    selectedCurrency: '',
    fee: '',
    start_datetime: '',
    end_datetime: '',
    closing_price: '',
    action: '',
    closingPNL: '',
    status: '',
    created_at: '',

});




const notifmsg = ref('');
const errors = ref({});


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

const getClass = (pnl) => {
    return pnl >= 0 ? "text-success" : "text-danger";
};
const saveData = () => {
    if (isSubmitting.value) return; // Prevent multiple submissions

    // Clear previous errors
    errors.close_price = '';
    // Check if `close_price` is empty
    if (!request.value.close_price) {
        error_noti();
        errors.close_price = ['Close price cannot be empty!']; // Assign array
        return; // Stop execution
    }
    const formData = new FormData();
    const id = router.currentRoute.value.query.parameter;
    formData.append('id', id);
    formData.append('action_type', request.value.action_type);
    formData.append('market_price', request.value.market_price);
    formData.append('close_price', request.value.close_price);
    formData.append('trade_amount', request.value.trade_amount);
    formData.append('selected_percentage', request.value.selected_percentage);

    axios.post('/trade/updateTrade', formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    })
        .then((res) => {

            success_noti();
            router.push({
                path: '/walletmanagement/trade-request-management',
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
    if (status == 0) {
        result = 'Runing';
    } else if (status === 1) {
        result = 'Complete';
    }
    return result;
}

const productDetails = () => {
    const id = router.currentRoute.value.query.parameter;
    axios.get(`/trade/traderow/${id}`).then(response => {
        const data = response.data;
        request.value.id = data.id;
        request.value.tradeID = data.tradeID;
        request.value.user_id = data.user_id;
        request.value.name = data.name;
        request.value.email = data.email;
        request.value.username = data.username;
        request.value.market_price = data.market_price;
        request.value.trade_amount = data.trade_amount;
        request.value.selected_duration = data.selected_duration;
        request.value.selected_percentage = data.selected_percentage;
        request.value.percentage_result = data.percentage_result;
        request.value.close_price = data.close_price;
        request.value.action_type = data.action_type;
        request.value.selectedCurrency = data.selectedCurrency;
        request.value.fee = data.fee;
        request.value.start_datetime = data.start_datetime;
        request.value.end_datetime = data.end_datetime;
        request.value.action = data.action;
        request.value.status = data.status;
        request.value.closingPNL = data.closingPNL;
        request.value.created_at = data.created_at;


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


const error_noti = () => {
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
        icon: "error",
        title: "Close price cannot be empty!"
    });
};
onMounted(() => {
    productDetails();
});
</script>