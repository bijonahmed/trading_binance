<template>
    <title>Deposit Preview</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Deposit Preview</p>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <LazyNuxtLink to="/admin/dashboard">Home</LazyNuxtLink>
                                </li>
                                <li class="breadcrumb-item active">
                                    <LazyNuxtLink to="/walletmanagement/deposit-management">Back to List</LazyNuxtLink>
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
                                                        <td width="40%">ID</td>
                                                        <td width="1%"><strong>:</strong></td>
                                                        <td width="50%">{{ request.depositID }}</td>
                                                    </tr>

                                                    <tr v-if="to_crypto_wallet_address">
                                                        <td width="40%">Deposit Address </td>
                                                        <td width="1%"><strong>:</strong></td>
                                                        <td width="50%">{{ request.to_crypto_wallet_address }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Request By</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.name }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Deposit Amount</td>
                                                        <td><strong>:</strong></td>
                                                        <td>$ {{ request.currencyName }} {{ request.deposit_amount }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Receivable Amount</td>
                                                        <td><strong>:</strong></td>
                                                        <td>$ {{ request.receivable_amount }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Payment Method </td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ request.payment_method }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Created Time</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ formatDate(request.created_at) }}</td>
                                                    </tr>

                                                    <tr>
                                                        <td>Status</td>
                                                        <td><strong>:</strong></td>
                                                        <td>{{ getStatus(request.status) }}</td>
                                                    </tr>

                                                </table>
                                                <center>Invoice Images</center>
                                                <center><img :src="request.deposit_image" alt="Deposit Image"
                                                        class="img-fluid rounded" width="150" /></center>
                                                <!-- Start Bank -->

                                                <center className="">
                                                    <p>Bank Details</p>
                                                </center>
                                                <table class="table table-hover">
                                                    <tbody>
                                                        <!-- Currency Symbol -->
                                                        <tr>
                                                            <td><strong>Currency Symbol</strong></td>
                                                            <td>{{ request.currencySymbol }}</td>
                                                        </tr>

                                                        <!-- Bank Name -->
                                                        <tr>
                                                            <td><strong>Bank Name</strong></td>
                                                            <td>{{ request.bank_name }}</td>
                                                        </tr>

                                                        <!-- Account Name -->
                                                        <tr>
                                                            <td><strong>Account Name</strong></td>
                                                            <td>{{ request.account_name }}</td>
                                                        </tr>

                                                        <!-- Account Number -->
                                                        <tr>
                                                            <td><strong>Account Number</strong></td>
                                                            <td>{{ request.account_number }}</td>
                                                        </tr>

                                                        <!-- IFIC Code (Conditional) -->
                                                        <tr v-if="request.ific_code">
                                                            <td><strong>IFIC Code</strong></td>
                                                            <td>{{ request.ific_code }}</td>
                                                        </tr>

                                                        <!-- SWIFT Code (Conditional) -->
                                                        <tr v-if="request.swift_code">
                                                            <td><strong>SWIFT Code</strong></td>
                                                            <td>{{ request.swift_code }}</td>
                                                        </tr>

                                                        <!-- Others Code (Conditional) -->
                                                        <tr v-if="request.others_code">
                                                            <td><strong>Others Code</strong></td>
                                                            <td>{{ request.others_code }}</td>
                                                        </tr>

                                                        <!-- Input Amount -->
                                                        <tr>
                                                            <td><strong>Input Amount</strong></td>
                                                            <td>{{ request.inputAmount }} {{ request.currencySymbol }}</td>
                                                        </tr>
                                                    </tbody>
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
                                                                class="col-sm-2 col-form-label required-label">Deposit
                                                                Amount</label>
                                                            <div class="col-sm-10">
                                                                <input type="text" name="name" placeholder="Name"
                                                                    v-model="request.deposit_amount" disabled readonly
                                                                    class="form-control" />
                                                            </div>
                                                        </div>


                                                        <div class="row mb-3 required">
                                                            <label for="input-name-1"
                                                                class="col-sm-2 col-form-label required-label">Receivable
                                                                Amount</label>
                                                            <div class="col-sm-10">
                                                                <input type="text" v-model="request.receivable_amount"
                                                                    autofocus class="form-control" />
                                                                <span class="text-danger"
                                                                    v-if="errors.receivable_amount">{{
                                                                        errors.receivable_amount[0] }}</span>
                                                            </div>
                                                        </div>


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
    deposit_image: '',
    //bank
    bank_name: '',
    account_name: '',
    account_number: '',
    ific_code: '',
    swift_code: '',
    others_code: '',
    inputAmount: '',

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

const saveData = () => {
    if (isSubmitting.value) return; // Prevent multiple submissions

    isSubmitting.value = true; // Disable button on click

    const recvAmt = String(request.value.receivable_amount);
    const recv_amount = parseInt(recvAmt.replace(/,/g, ''), 10);
    console.log("result" + recv_amount);

    const formData = new FormData();
    const id = router.currentRoute.value.query.parameter;
    formData.append('id', id);
    formData.append('receivable_amount', recv_amount);
    formData.append('status', request.value.status);

    axios.post('/deposit/updateDepositRequest', formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    })
        .then((res) => {

            success_noti();
            router.push({
                path: '/walletmanagement/deposit-management',
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
    axios.get(`/deposit/depositrow/${id}`).then(response => {
        const data = response.data;
        request.value.name = data.name;
        request.value.depositID = data.depositID;
        request.value.deposit_amount = data.deposit_amount;
        request.value.receivable_amount = data.receivable_amount;
        request.value.deposit_image = response.data.depositimage;
        request.value.payment_method = data.payment_method;
        request.value.approved_by = data.approved_by;
        request.value.created_at = data.created_at;
        request.value.to_crypto_wallet_address = data.to_crypto_wallet_address;
        request.value.currencyName = data.currencyName;
        request.value.gamePltformName = data.gamePltformName;
        request.value.frm_wallet_address = data.frm_wallet_address;
        request.value.trxId = data.trxId;
        request.value.status = data.status;
        //Show Bank
        request.value.currencySymbol = data.currencySymbol;
        request.value.bank_name = data.bank_name;
        request.value.account_name = data.account_name;
        request.value.account_number = data.account_number;
        request.value.ific_code = data.ific_code;
        request.value.swift_code = data.swift_code;
        request.value.others_code = data.others_code;
        request.value.inputAmount = data.inputAmount;


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