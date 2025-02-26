<template>
    <title>Affiliate Report</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header" style="margin-bottom: -25px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Affiliate Report</p>
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
                    <div class="page_top my-2">
                        <div class="row justify-content-between align-items-center my-2">
                            <div class="col-md-11">
                                <div class="row">
                                    <div class="col-lg-4 col-md-8 col-sm-12 mb-2">
                                        <input type="text" v-model="searchQuery" class="form-control"
                                            placeholder="Search by username..." />
                                        <small v-if="errors.username" class="text-danger">{{ errors.username }}</small>
                                    </div>

                                    <div class="col-lg-3 col-md-8 col-sm-12 mb-2">
                                        <input type="date" v-model="searchfrm" class="form-control"
                                            placeholder="From" />
                                        <small v-if="errors.fromDate" class="text-danger">{{ errors.fromDate }}</small>
                                    </div>

                                    <div class="col-lg-3 col-md-8 col-sm-12 mb-2">
                                        <input type="date" v-model="searchto" class="form-control" placeholder="To" />
                                        <small v-if="errors.toDate" class="text-danger">{{ errors.toDate }}</small>
                                    </div>

                                    <div class="col-lg-2 col-md-2 col-sm-6 mb-2">
                                        <button @click="filterData" class="btn btn-primary w-100">
                                            Filter
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- table section start here  -->
                    <div class="card">
                        <!-- /.card-header -->
                        <div class="card-body table-responsive p-0">
                            <div class="filter_options">
                                <div class="loading-indicator" v-if="loading" style="text-align: center">
                                    <Loader />
                                </div>
                            </div>

                            <!-- Start -->
                            <p>Total Team Count: <strong>{{ report.teamCount }}</strong></p>

                            <div v-for="(users, level) in report.level_data" :key="level">
                                <div><b>Level :{{ level }}</b></div>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>FG ID</th>
                                            <th>Invite Code</th>
                                            <th>Name</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Referrer Username</th>
                                            <th>Created At</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="user in users" :key="user.id">
                                            <td>{{ user.id }}</td>
                                            <td>{{ user.fg_id }}</td>
                                            <td>{{ user.inviteCode }}</td>
                                            <td>{{ user.name }}</td>
                                            <td>{{ user.username }}</td>
                                            <td>{{ user.email }}</td>
                                            <td>{{ user.ref_name }}</td>
                                            <td>{{ user.createdat }}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- END -->

                </div>
                <!-- /.card-body -->

                <!-- table section end here  -->

            </section>
        </div>
    </div>
</template>

<script setup>
import { ref, watch, onMounted } from "vue";
import axios from "axios";

import Swal from "sweetalert2";

definePageMeta({
    middleware: "is-logged-out",
});

const router = useRouter();
const loading = ref(false);
const searchQuery = ref("");
const searchfrm = ref("");
const searchto = ref("");
const total = ref(0);
const errors = ref({});
// Define a method to handle editing

const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleString('en-US', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour12: false
    });
}

const report = ref({
    status: '',
    message: '',
    level_data: {},
    teamCount: 0
});



const filterData = async () => {

    const username = searchQuery.value;
    const frmDate = searchfrm.value;
    const toDate = searchto.value;
    errors.value = {};
    if (!searchQuery.value) {
        errors.value.username = 'Username is required.';
    }
    // if (!searchfrm.value) {
    //     errors.value.fromDate = 'From date is required.';
    // }
    // if (!searchto.value) {
    //     errors.value.toDate = 'To date is required.';
    // }

    // If there are validation errors, stop the function
    if (Object.keys(errors.value).length > 0) {
        return;
    }


    try {
        loading.value = true;
        const response = await axios.get(`/user/makeAffilaiteReportAdmin`, {
            params: {
                username: username,
                frmDate: frmDate,
                toDate: toDate,

            }
        });
        if (response.data.status === 'success') {
            report.value.status = response.data.status;
            report.value.message = response.data.message;
            report.value.level_data = response.data.level_data;  // Assigning level data
            report.value.teamCount = response.data.teamCount;
        } else {
            report.value.message = response.data.message || 'Failed to load data';
        }


    } catch (error) {
        console.error("Error fetching data:", error);
    } finally {
        loading.value = false;
    }
};


</script>


<style>
h1 {
    font-size: 2rem;
    margin-bottom: 20px;
}

h2 {
    background-color: #007bff;
    color: white;
    padding: 10px;
    border-radius: 5px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

th,
td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

th {
    background-color: #f4f4f4;
}

.text-danger {
    font-size: 0.9rem;
}
</style>