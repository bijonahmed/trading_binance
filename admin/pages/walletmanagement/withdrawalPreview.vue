<template>
    <title>Withdrawal Details Preview</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Withdrawal Preview</p>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <LazyNuxtLink to="/admin/dashboard">Dashboard</LazyNuxtLink>
                                </li>
                                <li class="breadcrumb-item active">
                                    <LazyNuxtLink to="/walletmanagement/withdrawal-management">Back to List
                                    </LazyNuxtLink>
                                </li>
                            </ol>
                        </div>
                    </div>
                </div>
            </section>

            <!-- <button @click="productDetails">dfdfdf</button>  -->
            <section class="content">
                <div class="container-fluid">
                    <div v-if="apiError" class="alert alert-danger" role="alert">
                        {{ apiError }}
                    </div>
                    <!-- <center><button type="button" @click="productDetails">test</button></center> -->
                    <div class="col-xl-12 mx-auto">
                        <div class="card border-top border-0 border-4 border-info">
                            <div class="card-body">
                                <div class="border p-4 rounded">
                                    <div class="card">

                                        <div class="row">
                                            <div class="col-md-12">
                                                <table class="table table-bordered w-100">
                                                    <tr>
                                                        <td width="40%">ID</td>
                                                        <td width="1%"><strong>:</strong></td>
                                                        <td width="50%">{{ request.withdrawID }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Request By (Player)</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.name }}</td>
                                                    </tr>

                                                    <tr style="background-color: rgb(32, 77, 32); color: white;">
                                                        <td width="40%">Gaming Paltform</td>
                                                        <td width="1%"><strong>:</strong></td>
                                                        <td width="50%">{{ request.gamePltformName }}</td>
                                                    </tr>

                                                    <tr style="background-color: green; color: white;">
                                                        <td width="40%">Currency</td>
                                                        <td width="1%"><strong>:</strong></td>
                                                        <td width="50%">{{ request.currencyName }}</td>
                                                    </tr>


                                                    <tr>
                                                        <td>Amount</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.withdrawal_amount }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Payment Method</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.payment_method }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Request Wallet Address </td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.withdrwal_wallet_address }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Created Date</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.created_at }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Status</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ getStatus(request.status) }}</td>
                                                    </tr>

                                                </table>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="row">

                                        <div class="col-6">
                                            <form @submit.prevent="saveData()" id="formrest" class="forms-sample"
                                                enctype="multipart/form-data">
                                                <button type="submit" class="btn btn-danger btn-lg px-5 w-100 d-none">
                                                    <i class="bx bx-check-circle mr-1"></i>
                                                    Reject
                                                </button>
                                                <br><br>

                                                <div class="row mb-3 required d-none">
                                                    <br />
                                                    <label for="input-name-1"
                                                        class="col-sm-2 col-form-label required-label">Remarks</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" v-model="request.remarks" autofocus
                                                            class="form-control" />
                                                        <!-- <span class="text-danger" v-if="errors.remarks">{{ errors.remarks[0] }}</span> -->
                                                    </div>
                                                </div>
                                            </form>
                                        </div>

                                        <div class="col-6">

                                            <button type="submit" @click="submitToApproved" :disabled="isSubmitting"
                                                class="btn btn-info btn-lg px-5 w-100">
                                                <i class="bx bx-check-circle mr-1"></i>
                                                {{ isSubmitting ? 'Processing...' : 'Approved' }}
                                            </button>
                                        </div>

                                    </div>

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
    withdrawID: '',
    transection_fee: '',
    user_id: '',
    withdrawal_amount: '',
    gamePltformName: '',
    currencyName: '',
    usdt_amount: '',
    payable_amount: '',
    payment_method: '',
    wallet_address: '',
    currency_type_name: '',
    withdrwal_wallet_address: '',
    remarks: '',
    approved_by: '',
    apiError: '',
    created_at: '',
    name: '',
    status: '',

});
const apiError = ref(null);
const notifmsg = ref('');
const errors = ref({});
const isSubmitting = ref(false);


const submitToApproved = () => {
    if (isSubmitting.value) return; // Prevents further clicks

    isSubmitting.value = true;

    const id = router.currentRoute.value.query.parameter;
    const withdrawal_amount = request.value.withdrawal_amount;

    axios.get('/withdrawal/approvedWithdrawRequest', {
        params: {
            id: id,
            withdrawal_amount: withdrawal_amount
        }
    })
        .then((response) => {
            router.push({ path: '/walletmanagement/withdrawal-management' });
            swal.fire({
                title: "Success!",
                text: "Request approved",
                icon: "success",
                timer: 100
            });
        })
        .catch((error) => {
            console.error("Error approving request:", error);
        })
        .finally(() => {
            isSubmitting.value = false; // Re-enable the button if needed after completion
        });
};
const saveData = () => {
    if (request.value.remarks == "") {
        error_noti();
        return false;
    }

    const formData = new FormData();
    const id = router.currentRoute.value.query.parameter;
    formData.append('id', id);
    formData.append('remarks', request.value.remarks);
    formData.append('status', 2);

    axios.post('/withdrawal/withdrawalRequeseCancel', formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    }).then((res) => {
        //$('#formrest')[0].reset();
        success_noti();
        // Redirect to product variant page
        router.push({
            path: '/walletmanagement/withdrawal-management',
        });

    }).catch(error => {
        if (error.response && error.response.status === 422) {
            errors.value = error.response.data.errors;
        } else {
            // Handle other types of errors here
            console.error("An error occurred:", error);
        }
    });
};

const formatDate = (dateString) => {
    const date = new Date(dateString);
    const day = date.getDate().toString().padStart(2, '0');
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear();
    return `${day}/${month}/${year}`;
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
    axios.get(`/withdrawal/withdrawrow/${id}`).then(response => {
        console.log("created_at" + response.data.created_at);
        const wallet_address = response.data.wallet_address;
        console.log("request wallet address: " + wallet_address);

        request.value.name = response.data.username;
        request.value.email = response.data.email;
        request.value.withdrawID = response.data.withdrawID;
        request.value.gamePltformName = response.data.gamePltformName;
        request.value.currencyName = response.data.currencyName;
        request.value.withdrawal_amount = response.data.withdrawal_amount;
        request.value.payment_method = response.data.payment_method;
        request.value.withdrwal_wallet_address = response.data.withdrwal_wallet_address;
        request.value.created_at = response.data.createdate;
        request.value.status = response.data.status;

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
        title: "Has been successfully update"
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
        title: "Please write reject reason."
    });
};
onMounted(() => {
    productDetails();
});
</script>