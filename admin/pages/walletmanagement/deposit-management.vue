<template>
    <title>Deposit List</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Deposit List</p>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <LazyNuxtLink to="/admin/dashboard">Dashboard</LazyNuxtLink>
                                </li>

                            </ol>
                        </div>
                    </div>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid">

                    <!-- Bootstrap Modal -->
                    <div class="modal" id="balanceModal" tabindex="-1" aria-labelledby="balanceModalLabel"
                        aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header bg-primary">
                                    <h5 class="modal-title" id="balanceModalLabel">ID: [{{ depositId }}]</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <center>
                                        <div class="loading-indicator" v-if="loading" style="text-align: center;">
                                            <Loader />
                                        </div>
                                        <!-- Display balance when loading is done -->
                                        <h2 v-else>{{ currentBalance }}</h2>

                                    </center>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                        @click="closeModal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-lg-2 col-md-3 col-sm-12 mb-2">
                                    <input type="email" v-model="searchEmail" class="form-control"
                                        placeholder="Search Username" />
                                </div>

                                <div class="col-lg-2 col-md-3 col-sm-12 mb-2">
                                    <input type="text" v-model="searchOrderId" class="form-control"
                                        placeholder="Search Deposit  ID" />
                                </div>

                                <div class="col-lg-2 col-md-3 col-sm-12 mb-2">
                                    <input type="date" v-model="filterFrmDate" class="form-control" />
                                </div>

                                <div class="col-lg-2 col-md-3 col-sm-12 mb-2">
                                    <input type="date" v-model="filterToDate" class="form-control" />
                                </div>

                                <div class="col-lg-2 col-md-2 col-sm-6 mb-2">
                                    <select v-model="selectedFilter" class="form-control" @change="filterData">
                                        <option value="">All</option>
                                        <option value="0">Pending</option>
                                        <option value="2">Reject</option>
                                        <option value="1">Approved</option>
                                    </select>
                                </div>

                                <div class="col-lg-1 col-md-2 col-sm-6 mb-2">
                                    <button @click="filterData()" class="btn btn-primary w-100">Filter</button>
                                </div>
                            </div>
                            <div class="card">
                                <div class="loading-indicator" v-if="loading" style="text-align: center;">
                                    <Loader />
                                </div>
                                <div class="card-body">

                                    <table class="table w-100 table-wrapper">
                                        <thead>
                                            <tr>
                                                <th class="text-left">ID</th>
                                                <th class="text-left">User Info</th>
                                                <th class="text-left">Date</th>
                                                <th class="text-center">Deposit Amount</th>
                                                <th class="text-center">Receivable Amount</th>
                                                <th class="text-center">Status</th>
                                                <th class="text-center">Type</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="(pro, index) in productdata" :key="index">
                                                <td class="text-left">{{ pro.depositID }}<br/>
                                                </td>
                                                <td class="text-left"><small>Username: {{ pro.username }}<br />Email:
                                                        {{ pro.email }}</small></td>
                                                <td class="text-left">{{ pro.deposit_date }}</td>
                                                <td class="text-center">{{ pro.deposit_amount }}</td>


                                             
                                                <td class="text-center">

                                                    <span style="color:green;">{{ pro.currencyName }}&nbsp;{{
                                                        pro.receivable_amount }}</span>


                                                </td>


                                                <td class="text-center">
                                                    <span v-if="pro.status == 0"
                                                        class="badge rounded-pill bg-secondary w-100">{{ pro.statusName
                                                        }}</span>
                                                    <span class="badge rounded-pill bg-success w-100"
                                                        v-if="pro.status == 1">{{ pro.statusName }}</span>
                                                    <span class="badge rounded-pill bg-danger w-100"
                                                        v-if="pro.status == 2">{{ pro.statusName }}</span>
                                                </td>
                                                <td class="text-center">{{ pro.payment_method }}</td>

                                                <td>
                                                    <center>
                                                        <button class="btn btn-default btn-sm btn-flat"
                                                            @click="preview(pro.id)"><i
                                                                class="fa fa-check"></i>Check</button>

                                                        <button class="btn btn-danger btn-sm btn-flat"
                                                            @click="cancelDeposit(pro.id)"><i
                                                                class="fa fa-times"></i>Reject</button>

                                                        <!-- <button class="btn btn-primary btn-sm btn-flat"
                                                            @click="cancelDeposit(pro.id)"><i
                                                                class="fa fa-times"></i>Cancel</button>


                                                        <button class="btn btn-info btn-sm btn-flat"
                                                            @click="checkBalance(pro)"><i class="fa fa-money"></i>Check
                                                            Balance</button> -->


                                                    </center>
                                                </td>
                                            </tr>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th class="text-left">ID</th>
                                                <th class="text-left">User Info</th>
                                                <th class="text-left">Date</th>
                                                <th class="text-center">Deposit Amount</th>
                                                <th class="text-center">Receivable Amount</th>
                                                <th class="text-center">Status</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </tfoot>
                                    </table>

                                    <center>
                                        <div class="pagination" style="text-align: center; font-size: 12px;">
                                            <button :disabled="currentPage === 1" @click="fetchData(currentPage - 1)">
                                                Previous
                                            </button>
                                            <template v-for="pageNumber in displayedPages" :key="pageNumber">
                                                <button @click="fetchData(pageNumber)">
                                                    {{ pageNumber }}
                                                </button>
                                            </template>
                                            <button :disabled="currentPage === totalPages"
                                                @click="fetchData(currentPage + 1)">
                                                Next
                                            </button>
                                        </div>
                                    </center>

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

import { ref, watch, onMounted } from "vue";
import axios from "axios";
import { Modal } from 'bootstrap';

import swal from 'sweetalert2';
window.Swal = swal;


definePageMeta({
    middleware: 'is-logged-out',
})

const router = useRouter();
const loading = ref(false);
const currentPage = ref(1);
const pageSize = 10;
const totalRecords = ref(0);
const totalPages = ref(0);
const productdata = ref([]);
const searchOrderId = ref("");
const searchEmail = ref("");
const selectedFilter = ref(0);
const currentBalance = ref(0);
const depositId = ref(0);

// Get today's date in YYYY-MM-DD format
const today = new Date();
const yyyy = today.getFullYear();
const mm = String(today.getMonth() + 1).padStart(2, '0');
const dd = String(today.getDate()).padStart(2, '0');
const formattedDate = `${yyyy}-${mm}-${dd}`;
// Define a reactive ref to store the current date
const filterFrmDate = ref(formattedDate);
const filterToDate = ref(formattedDate);
const fetchData = async (page) => {
    try {
        loading.value = true;
        const response = await axios.get(`/deposit/depositHistoryReportAdmin`, {
            params: {
                page: page,
                pageSize: pageSize,
                searchEmail: searchEmail.value, // Pass the search query parameter
                selectedFilter: selectedFilter.value, // Pass the search query parameter
                searchOrderId: searchOrderId.value, // Pass the search query parameter
                filterFrmDate: filterFrmDate.value, // Pass the search query parameter
                filterToDate: filterToDate.value, // Pass the search query parameter
            },
        });
        productdata.value = response.data.data;
        totalRecords.value = response.data.total_records;
        totalPages.value = response.data.total_pages;
        currentPage.value = response.data.current_page;
    } catch (error) {
        // Handle error
    } finally {
        loading.value = false;
    }
};

onMounted(() => {
    fetchData(currentPage.value);
});

// Watch for changes in current page and fetch data accordingly
watch(currentPage, (newPage) => {
    fetchData(newPage);
});

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


// Define a method to handle previewing
const preview = (id) => {
    router.push({
        path: '/walletmanagement/depositpreview',
        query: {
            parameter: id
        }
    });
    console.log('Previewing item with id:', id);
};

const checkBalance = async (data) => {
    const modalElement = document.getElementById('balanceModal');
    const modalInstance = new Modal(modalElement);
    modalInstance.show();
    const id = data.id;
    depositId.value = data.username;
    try {
        loading.value = true;
        const response = await axios.get(`/balance/checkBalanceAdmin/${id}`);
        if (response.data.code == 10000) {
            currentBalance.value = "Balance : " + response.data.currency + ' ' + response.data.data.balance;
        } else {
            Toast.fire({
                icon: "error",
                title: response.data.msg
            });
            currentBalance.value = response.data.msg; // Reset balance if error occurs
        }
    } catch (error) {
        // Handle network or server errors
        Toast.fire({
            icon: "error",
            title: "An error occurred while fetching balance."
        });
        currentBalance.value = null;
    } finally {
        // Hide loader and show modal after request completes
        loading.value = false;
        const modalElement = document.getElementById('balanceModal');
        const modalInstance = new Modal(modalElement);
        modalInstance.show();
    }
};

const closeModal = () => {

    const modalElement = document.getElementById('balanceModal');
    // Hide modal manually
    modalElement.classList.remove('show');
    modalElement.style.display = 'none';
    document.body.classList.remove('modal-open');

    // Remove backdrop manually
    const backdrop = document.querySelector('.modal-backdrop');
    if (backdrop) {
        backdrop.parentNode.removeChild(backdrop);
    }
};



const cancelDeposit = (id) => {
    swal.fire({
        title: 'Are you sure?',
        text: 'Do you really want to cancel this deposit?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, cancel it!',
        cancelButtonText: 'No, keep it'
    }).then((result) => {
        if (result.isConfirmed) {

            axios.get(`/deposit/depositCancel/${id}`).then((response) => {
                console.log("response:" + response.data);
                filterData();
            });
            console.log('Cancelled deposit with id:', id);
            swal.fire(
                'Cancelled!',
                'The deposit has been successfully cancelled.',
                'success'
            );
        } else {
            console.log('Cancellation aborted for id:', id);
        }
    });
};






const previewReject = (id) => {
    alert(id);
    router.push({
        path: '/walletmanagement/depositpreview',
        query: {
            parameter: id
        }
    });
    console.log('Previewing item with id:', id);
};





// Compute the range of displayed pages
const displayedPages = computed(() => {
    const maxDisplayedPages = 10; // Maximum number of displayed pages
    const startPage = Math.max(
        1,
        currentPage.value - Math.floor(maxDisplayedPages / 2)
    );
    const endPage = Math.min(
        totalPages.value,
        startPage + maxDisplayedPages - 1
    );
    return Array.from(
        { length: endPage - startPage + 1 },
        (_, i) => startPage + i
    );
});


const filterData = () => {
    fetchData(1); // Reset to first page when search query changes
};
</script>


<style>
.pagination {
    display: inline-block;
    text-align: center;
}

.pagination button {
    margin: 0 5px;
    padding: 5px 10px;
    background-color: #2f2f2f;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.pagination button:hover {
    background-color: #0056b3;
}

.pagination button[disabled] {
    background-color: #6c757d;
    cursor: not-allowed;
}

.card-body {
    -ms-flex: 1 1 auto;
    flex: 1 1 auto;
    min-height: 1px;
    padding: 0.5rem;
}

.btnSize {
    font-size: 12px;
    padding: 3px;
}

/* Table */
.table-wrapper {
    width: 100%;
    /* max-width: 500px; */
    overflow-x: auto;
}

.table td,
.table th {
    padding: .2rem;
    vertical-align: top;
    border-top: 1px solid #dae2ea;
}

table {
    border-collapse: collapse;
    width: 100%;
}

th,
td {
    padding: 1px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

tr:hover {
    background-color: rgb(221, 221, 221);
}
</style>
