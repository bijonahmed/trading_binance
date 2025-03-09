<template>
    <title>Pyament List</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Pyament Setting</p>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <LazyNuxtLink to="/admin/dashboard">Dashboard</LazyNuxtLink>
                                </li>
                                <!-- <li class="breadcrumb-item active">
                                    <LazyNuxtLink to="/setting/bank/add">New Bank</LazyNuxtLink>
                                </li> -->
                            </ol>
                        </div>
                    </div>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">


                            <div class="card">
                                <div class="loading-indicator" v-if="loading" style="text-align: center;">
                                    <Loader />
                                </div>
                                <div class="card-body">
                                    <!-- start -->
                                    <!-- ./row -->
                                    <div class="row">
                                        <div class="col-12 col-sm-12">
                                            <div class="card card-primary card-tabs">
                                                <div class="card-header p-0 pt-1">
                                                    <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
                                                        <li class="nav-item" @click="fetechMobileBankingData">
                                                            <a class="nav-link active" id="custom-tabs-one-home-tab"
                                                                data-toggle="pill" href="#custom-tabs-one-home"
                                                                role="tab" aria-controls="custom-tabs-one-home"
                                                                aria-selected="true">Mobile Banking</a>
                                                        </li>
                                                        <li class="nav-item" @click="fetechCountryWiseBank">
                                                            <a class="nav-link" id="custom-tabs-one-profile-tab"
                                                                data-toggle="pill" href="#custom-tabs-one-profile"
                                                                role="tab" aria-controls="custom-tabs-one-profile"
                                                                aria-selected="false">Bank Setting</a>
                                                        </li>

                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <div class="tab-content" id="custom-tabs-one-tabContent">
                                                        <div class="tab-pane fade show active" id="custom-tabs-one-home"
                                                            role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">
                                                            <div class="row">
                                                                <div class="col-6">
                                                                    <form @submit.prevent="saveMobileWallet()"
                                                                        id="formrest" class="forms-sample"
                                                                        enctype="multipart/form-data">
                                                                        <div class="card-body">
                                                                            <div class="tab-content"
                                                                                id="custom-tabs-three-tabContent">
                                                                                <div class="tab-pane fade active show"
                                                                                    id="custom-tabs-three-home"
                                                                                    role="tabpanel"
                                                                                    aria-labelledby="custom-tabs-three-home-tab">
                                                                                    <!-- General  -->
                                                                                    <div v-if="errors.length"
                                                                                        class="text-danger text-center">
                                                                                        <div v-for="(error, index) in errors"
                                                                                            :key="index"
                                                                                            class="error-message">
                                                                                            * {{ error }}
                                                                                        </div>
                                                                                    </div>


                                                                                    <!-- <span class="text-danger" v-if="errors_name">{{errors_name}}</span> -->
                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-3 col-form-label required-label">Select
                                                                                            Country</label>
                                                                                        <div class="col-sm-9">
                                                                                            <select
                                                                                                v-model="insertdata.country_id"
                                                                                                class="form-control">
                                                                                                <option value="">Select
                                                                                                    a
                                                                                                    country</option>
                                                                                                <option
                                                                                                    v-for="country in countryList"
                                                                                                    :key="country.id"
                                                                                                    :value="country.id">
                                                                                                    {{ country.name }}
                                                                                                </option>
                                                                                            </select>
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.country_id">{{
                                                                                                    errors.country_id[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>


                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-3 col-form-label required-label">Mobile
                                                                                            Wallet Name</label>
                                                                                        <div class="col-sm-9">

                                                                                            <input type="text"
                                                                                                v-model="insertdata.name"
                                                                                                class="form-control"
                                                                                                placeholder="Upay, Bkash etc..." />


                                                                                            <span class="text-danger"
                                                                                                v-if="errors.name">{{
                                                                                                    errors.name[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>



                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-3 col-form-label required-label">Status</label>
                                                                                        <div class="col-sm-9">
                                                                                            <select
                                                                                                v-model="insertdata.status"
                                                                                                class="form-control">
                                                                                                <option value="">Select
                                                                                                    Status</option>
                                                                                                <option value="1">Active
                                                                                                </option>
                                                                                                <option value="0">
                                                                                                    Inactive</option>
                                                                                            </select>
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.status">{{
                                                                                                    errors.status[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>



                                                                                    <button type="submit"
                                                                                        class="btn btn-success px-5 w-100">
                                                                                        <i
                                                                                            class="bx bx-check-circle mr-1"></i>
                                                                                        Save
                                                                                    </button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                                <div class="col-6">
                                                                    <div class="table-responsive">
                                                                        <table class="table table-hover table-striped">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>Country</th>
                                                                                    <th>Name</th>
                                                                                    <th>Status</th>
                                                                                    <th>Action</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr v-for="item in mbanking"
                                                                                    :key="item.id">
                                                                                    <td>{{ item.country_name }}</td>
                                                                                    <td>{{ item.name }}</td>
                                                                                    <td>{{ item.status == 1 ? 'Active'
                                                                                        :'Inactive' }}</td>

                                                                                    <td><button
                                                                                            @click="findrow(item.id)">&nbsp;Edit&nbsp;</button>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>




                                                        </div>
                                                        <div class="tab-pane fade" id="custom-tabs-one-profile"
                                                            role="tabpanel"
                                                            aria-labelledby="custom-tabs-one-profile-tab">

                                                            <!-- {{ activeCountryList }} -->

                                                            <!-- Start -->
                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <form @submit.prevent="saveBankingSetting()"
                                                                        id="formrest_cb" class="forms-sample"
                                                                        enctype="multipart/form-data">
                                                                        <div class="card-body">
                                                                            <div class="tab-content"
                                                                                id="custom-tabs-three-tabContent">
                                                                                <div class="tab-pane fade active show"
                                                                                    id="custom-tabs-three-home"
                                                                                    role="tabpanel"
                                                                                    aria-labelledby="custom-tabs-three-home-tab">
                                                                                    <!-- General  -->
                                                                                    <div v-if="errors.length"
                                                                                        class="text-danger text-center">
                                                                                        <div v-for="(error, index) in errors"
                                                                                            :key="index"
                                                                                            class="error-message">
                                                                                            * {{ error }}
                                                                                        </div>
                                                                                    </div>


                                                                                    <!-- <span class="text-danger" v-if="errors_name">{{errors_name}}</span> -->
                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-4 col-form-label required-label">Country</label>
                                                                                        <div class="col-sm-8">
                                                                                            <select
                                                                                                v-model="insertdata_bank.country_id"
                                                                                                class="form-control">
                                                                                                <option value="">Country
                                                                                                </option>
                                                                                                <option
                                                                                                    v-for="country in activeCountryList"
                                                                                                    :key="country.id"
                                                                                                    :value="country.country_id">
                                                                                                    {{
                                                                                                        country.country_name
                                                                                                    }}
                                                                                                </option>
                                                                                            </select>
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.country_id">{{
                                                                                                    errors.country_id[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>


                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-4 col-form-label required-label">Bank
                                                                                            Name</label>
                                                                                        <div class="col-sm-8">
                                                                                            <input type="text"
                                                                                                v-model="insertdata_bank.bank_name"
                                                                                                class="form-control" />
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.bank_name">{{
                                                                                                    errors.bank_name[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>



                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-4 col-form-label required-label">Status</label>
                                                                                        <div class="col-sm-8">
                                                                                            <select
                                                                                                v-model="insertdata_bank.status"
                                                                                                class="form-control">
                                                                                                <option value="">Select
                                                                                                    Status</option>
                                                                                                <option value="1">Active
                                                                                                </option>
                                                                                                <option value="0">
                                                                                                    Inactive</option>
                                                                                            </select>
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.status">{{
                                                                                                    errors.status[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>

                                                                                    <button type="submit"
                                                                                        class="btn btn-success px-5 w-100">
                                                                                        <i
                                                                                            class="bx bx-check-circle mr-1"></i>
                                                                                        Save
                                                                                    </button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                                <div class="col-8">
                                                                    <div class="table-responsive">
                                                                        <table class="table table-hover table-striped">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th class="text-left">Name</th>
                                                                                    <th>Country</th>
                                                                                    <th>Status</th>
                                                                                    <th>Action</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr v-for="item in country_wise_bank_list" :key="item.id">
                                                                                    <td class="text-left">{{ item.bank_name ||'' }}</td>

                                                                                    <td>{{ item.country_name }}</td>
                                                                                   
                                                                                    <td>{{ item.status == 1 ? 'Active' :
                                                                                        'Inactive' }}</td>
                                                                                    
                                                                                    <td><button
                                                                                            @click="findCountryWiseBankrow(item.id)">&nbsp;Edit&nbsp;</button>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- END -->







                                                        </div>

                                                    </div>
                                                </div>
                                                <!-- /.card -->
                                            </div>
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
import { ref, reactive, onMounted } from "vue";
import axios from "axios";
import Swal from "sweetalert2";

window.Swal = Swal;
const errors = ref([]);
const countryList = ref([]);
const currencyList = ref([]);
const activeCountryList = ref([]);
const mbanking = ref([]);
const country_wise_bank_list = ref([]);

definePageMeta({
    middleware: 'is-logged-out',
    title: 'Profile' // Set your desired page title here

})
const router = useRouter();
const loading = ref(false);

const insertdata = reactive({
    id: '',
    country_id: "",
    name: "",
    status: 1,
});



const insertdata_bank = reactive({
    id: '',
    //add_bank_id: "",
    country_id: "",
    bank_name: "",
    account_name: "",
    account_number: "",
    ific_code: "",
    swift_code: "",
    others_code: "",
    status: 1,
});

const findCountryWiseBankrow = async (id) => {

    try {
        loading.value = true;
        const response = await axios.get('/setting/getBankRow', {
            params: {
                id: id,
            }
        });
        //console.log("===-==" + response.data.data);
        insertdata_bank.id = response.data.data.id;
        insertdata_bank.country_id = response.data.data.country_id;
        insertdata_bank.bank_name = response.data.data.name;
        insertdata_bank.status = response.data.data.status;
        //mbanking.value = response.data.data;
    } catch (error) {
        console.error("Error fetching country currency list:", error);
    } finally {
        loading.value = false;
    }
}

const findrow = async (id) => {
    try {
        loading.value = true;
        const response = await axios.get('/setting/getMobileBankRow', {
            params: {
                id: id,
            }
        });
        //console.log("===-==" + response.data.data);
        insertdata.id = response.data.data.id;
        insertdata.name = response.data.data.name;
        insertdata.country_id = response.data.data.country_id;
        insertdata.status = response.data.data.status;
        //mbanking.value = response.data.data;
    } catch (error) {
        console.error("Error fetching country currency list:", error);
    } finally {
        loading.value = false;
    }
}

const isNumber = ($event) => {
    let keyCode = $event.keyCode ? $event.keyCode : $event.which;
    if ((keyCode < 48 || keyCode > 57) && keyCode !== 46) {
        // 46 is dot
        $event.preventDefault();
    }
};

const countryWiseBank = async () => {
    try {
        const response = await axios.get(`/setting/countryWiseShowBank`);
        if (response.data) {
            activeCountryList.value = response.data.data;
        }
    } catch (error) {
        console.error("Error fetching bank list:", error);
    }
};



const fetechCountryWiseBank = async () => {
    try {
        loading.value = true;
        const response = await axios.get(`/setting/getCountryBankSettingList`);
        if (response.data) {
            country_wise_bank_list.value = response.data.data;
        }
    } catch (error) {
        console.error("Error fetching bank list:", error);
    } finally {
        loading.value = false;
    }
};

const fetechMobileBankingData = async () => {
    countryWiseBank();
    try {
        loading.value = true;
        const response = await axios.get(`/setting/getMobileBankingList`);
        if (response.data) {
            mbanking.value = response.data.data;
        }
    } catch (error) {
        console.error("Error fetching bank list:", error);
    } finally {
        loading.value = false;
    }
};




const fetchCountryData = async () => {
    try {
        loading.value = true;
        const response = await axios.get(`/setting/getCuntryCurrencyList`);
        if (response.data) {
            countryList.value = response.data.data.countryList;
            currencyList.value = response.data.data.currencyList;
        }
    } catch (error) {
        console.error("Error fetching bank list:", error);
    } finally {
        loading.value = false;
    }
};



const saveBankingSetting = () => {

    const formData = new FormData();
    formData.append("id", insertdata_bank.id);
    formData.append("country_id", insertdata_bank.country_id);
    formData.append("name", insertdata_bank.bank_name);
    formData.append("status", insertdata_bank.status);
    axios
        .post("/setting/addBank", formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        })
        .then((res) => {
            insertdata_bank.country_id = "";
            insertdata_bank.bank_name = "";
            insertdata_bank.account_name = "";
            insertdata_bank.account_number = "";
            insertdata_bank.ific_code = "";
            insertdata_bank.swift_code = "";
            insertdata_bank.others_code = "";
            //insertdata_bank.status = "";
            $("#formrest_cb")[0].reset();
            success_noti();
            fetechCountryWiseBank();
        })
        .catch((error) => {
            if (error.response && error.response.status === 422) {
                // Check if general validation errors are present
                if (error.response.data.errors) {
                    errors.value = Object.values(error.response.data.errors).flat();
                }

            } else {
                // Handle other types of errors here
                console.error("An error occurred:", error);
            }
        });

}


const saveMobileWallet = () => {
    //console.log("===ID:"+ insertdata.id); return false; 
    const formData = new FormData();
    formData.append("id", insertdata.id);
    formData.append("country_id", insertdata.country_id);
    formData.append("name", insertdata.name);
    formData.append("status", insertdata.status);
    axios
        .post("/setting/addMobileBanking", formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        })
        .then((res) => {
            // insertdata.country_id = "";
            insertdata.name = "";
            // insertdata.status = "";
            $("#formrest")[0].reset();
            success_noti();
            fetechMobileBankingData();
        })
        .catch((error) => {
            if (error.response && error.response.status === 422) {
                // Check if general validation errors are present
                if (error.response.data.errors) {
                    errors.value = Object.values(error.response.data.errors).flat();
                }

            } else {
                // Handle other types of errors here
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
        },
    });
    Toast.fire({
        icon: "success",
        title: "Your notification has been successfully send.",
    });
};

onMounted(() => {
    fetechCountryWiseBank();
    countryWiseBank();
    fetechMobileBankingData();
    fetchCountryData();
});



</script>

<style></style>
