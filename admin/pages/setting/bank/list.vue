<template>
    <title>Bank List</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Bank & Currency Setting</p>
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
                                                        <li class="nav-item" @click="fetechCountryCurrencyData">
                                                            <a class="nav-link active" id="custom-tabs-one-home-tab"
                                                                data-toggle="pill" href="#custom-tabs-one-home"
                                                                role="tab" aria-controls="custom-tabs-one-home"
                                                                aria-selected="true">Add Country & Currency</a>
                                                        </li>
                                                        <li class="nav-item" @click="fetechCountryWiseBank">
                                                            <a class="nav-link" id="custom-tabs-one-profile-tab"
                                                                data-toggle="pill" href="#custom-tabs-one-profile"
                                                                role="tab" aria-controls="custom-tabs-one-profile"
                                                                aria-selected="false">Country Wise Bank</a>
                                                        </li>

                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <div class="tab-content" id="custom-tabs-one-tabContent">
                                                        <div class="tab-pane fade show active" id="custom-tabs-one-home"
                                                            role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">
                                                            <div class="row">
                                                                <div class="col-6">
                                                                    <form @submit.prevent="saveDataCountry()"
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
                                                                                            class="col-sm-3 col-form-label required-label">Select
                                                                                            Currency </label>
                                                                                        <div class="col-sm-9">
                                                                                            <select
                                                                                                v-model="insertdata.currency_id"
                                                                                                class="form-control">
                                                                                                <option value="">Select
                                                                                                    a
                                                                                                    currency</option>
                                                                                                <option
                                                                                                    v-for="currency in currencyList"
                                                                                                    :key="currency.id"
                                                                                                    :value="currency.id">
                                                                                                    {{ currency.name }}
                                                                                                </option>
                                                                                            </select>
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.currency_id">{{
                                                                                                    errors.currency_id[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>


                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-3 col-form-label required-label">USD
                                                                                            Rate</label>
                                                                                        <div class="col-sm-9">
                                                                                            <input type="text"
                                                                                                v-model="insertdata.usdt_rate"
                                                                                                class="form-control"
                                                                                                @keypress="isNumber($event)" />
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.usdt_rate">{{
                                                                                                    errors.usdt_rate[0]
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
                                                                                    <th>Currency</th>
                                                                                    <th>Status</th>
                                                                                    <th>USD Rate</th>
                                                                                    <th>Action</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr v-for="item in country_currencylist"
                                                                                    :key="item.id">
                                                                                    <td>{{ item.country_name }}</td>
                                                                                    <td>{{ item.currency_name }}[{{
                                                                                        item.currency_symbol }}]</td>
                                                                                    <td>{{ item.status == 1 ? 'Active' :
                                                                                        'Inactive' }}</td>
                                                                                    <td>{{ item.usdt_rate }}</td>
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
                                                                    <form @submit.prevent="saveDataCountryWiseBank()"
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
                                                                                            class="col-sm-4 col-form-label required-label">Account
                                                                                            Name</label>
                                                                                        <div class="col-sm-8">
                                                                                            <input type="text"
                                                                                                v-model="insertdata_bank.account_name"
                                                                                                class="form-control" />
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.account_name">{{
                                                                                                    errors.account_name[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>


                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-4 col-form-label required-label">Account
                                                                                            Number</label>
                                                                                        <div class="col-sm-8">
                                                                                            <input type="text"
                                                                                                v-model="insertdata_bank.account_number"
                                                                                                class="form-control"
                                                                                                @keypress="isNumber($event)" />
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.account_number">{{
                                                                                                    errors.account_number[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>

                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-4 col-form-label required-label">IFIC
                                                                                            Code</label>
                                                                                        <div class="col-sm-8">
                                                                                            <input type="text"
                                                                                                v-model="insertdata_bank.ific_code"
                                                                                                class="form-control" />
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.ific_code">{{
                                                                                                    errors.ific_code[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>

                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-4 col-form-label required-label">SWIFT
                                                                                            Code</label>
                                                                                        <div class="col-sm-8">
                                                                                            <input type="text"
                                                                                                v-model="insertdata_bank.swift_code"
                                                                                                class="form-control" />
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.swift_code">{{
                                                                                                    errors.swift_code[0]
                                                                                                }}</span>
                                                                                        </div>
                                                                                    </div>

                                                                                    <div class="row mb-3 required">
                                                                                        <label for="input-name-1"
                                                                                            class="col-sm-4 col-form-label required-label">Others
                                                                                            Code</label>
                                                                                        <div class="col-sm-8">
                                                                                            <input type="text"
                                                                                                v-model="insertdata_bank.others_code"
                                                                                                class="form-control"
                                                                                                @keypress="isNumber($event)" />
                                                                                            <span class="text-danger"
                                                                                                v-if="errors.others_code">{{
                                                                                                    errors.others_code[0]
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
                                                                                    <th class="text-left">Bank Info</th>
                                                                                    <th>Country</th>
                                                                                    <th>Currency</th>
                                                                                    <th>Status</th>
                                                                                    <th>USD Rate</th>
                                                                                    <th>Action</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr v-for="item in country_wise_bank_list"
                                                                                    :key="item.id">
                                                                                    <td class="text-left">
                                                                                        Bank Name: {{ item.bank_name ||
                                                                                        '' }}
                                                                                        <br />Acc. Name: {{
                                                                                            item.account_name || '' }}
                                                                                        <br />Acc. Num:
                                                                                        {{ item.account_number || '' }}
                                                                                        <span
                                                                                            v-if="item.swift_code && item.swift_code !== ''"><br />SWIFT
                                                                                            Code: {{ item.swift_code
                                                                                            }}</span>
                                                                                        <span
                                                                                            v-if="item.ific_code && item.ific_code !== ''"><br />IFIC
                                                                                            Code: {{ item.ific_code
                                                                                            }}</span>
                                                                                        <span
                                                                                            v-if="item.others_code && item.others_code !== ''"><br />Others
                                                                                            Code: {{ item.others_code
                                                                                            }}</span>


                                                                                    </td>

                                                                                    <td>{{ item.country_name }}</td>
                                                                                    <td>{{ item.currency_name }}[{{
                                                                                        item.currency_symbol }}]</td>
                                                                                    <td>{{ item.status == 1 ? 'Active' :
                                                                                        'Inactive' }}</td>
                                                                                    <td>{{ item.usdt_rate }}</td>
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
const country_currencylist = ref([]);
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
    currency_id: "",
    usdt_rate: "",
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
        const response = await axios.get('/setting/getCountryWiseBankRow', {
            params: {
                id: id,
            }
        });
        //console.log("===-==" + response.data.data);
        insertdata_bank.id = response.data.data.id;
        insertdata_bank.country_id = response.data.data.country_id;
        insertdata_bank.bank_name = response.data.data.bank_name;
        insertdata_bank.account_name = response.data.data.account_name;
        insertdata_bank.account_number = response.data.data.account_number;
        insertdata_bank.ific_code = response.data.data.ific_code;
        insertdata_bank.swift_code = response.data.data.swift_code;
        insertdata_bank.others_code = response.data.data.others_code;
        insertdata_bank.others_code = response.data.data.others_code;
        //country_currencylist.value = response.data.data;
    } catch (error) {
        console.error("Error fetching country currency list:", error);
    } finally {
        loading.value = false;
    }
}

const findrow = async (id) => {
    try {
        loading.value = true;
        const response = await axios.get('/setting/getCountryRow', {
            params: {
                id: id,
            }
        });
        //console.log("===-==" + response.data.data);
        insertdata_bank.id = response.data.data.id;
        insertdata_bank.country_id = response.data.data.country_id;
        insertdata_bank.currency_id = response.data.data.currency_id;
        insertdata_bank.usdt_rate = response.data.data.usdt_rate;
        insertdata_bank.status = response.data.data.status;
        //country_currencylist.value = response.data.data;
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
        const response = await axios.get(`/setting/getCountryBankList`);
        if (response.data) {
            country_wise_bank_list.value = response.data.data;
        }
    } catch (error) {
        console.error("Error fetching bank list:", error);
    } finally {
        loading.value = false;
    }
};

const fetechCountryCurrencyData = async () => {
    countryWiseBank();
    try {
        loading.value = true;
        const response = await axios.get(`/setting/getCountryCurrencyList`);
        if (response.data) {
            country_currencylist.value = response.data.data;
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



const saveDataCountryWiseBank = () => {

    const formData = new FormData();
    formData.append("id", insertdata_bank.id);
    formData.append("country_id", insertdata_bank.country_id);
    formData.append("bank_name", insertdata_bank.bank_name);
    formData.append("account_name", insertdata_bank.account_name);
    formData.append("account_number", insertdata_bank.account_number);
    formData.append("ific_code", insertdata_bank.ific_code);
    formData.append("swift_code", insertdata_bank.swift_code);
    formData.append("others_code", insertdata_bank.others_code);
    formData.append("status", insertdata_bank.status);
    axios
        .post("/setting/addCountryWiseBank", formData, {
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


const saveDataCountry = () => {
    //console.log("===ID:"+ insertdata.id); return false; 
    const formData = new FormData();
    formData.append("id", insertdata.id);
    formData.append("country_id", insertdata.country_id);
    formData.append("currency_id", insertdata.currency_id);
    formData.append("usdt_rate", insertdata.usdt_rate);
    formData.append("status", insertdata.status);
    axios
        .post("/setting/addCountryInfo", formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        })
        .then((res) => {
            insertdata.country_id = "";
            insertdata.currency_id = "";
            insertdata.usdt_rate = "";
            $("#formrest")[0].reset();
            success_noti();
            fetechCountryCurrencyData();
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
    fetechCountryCurrencyData();
    fetchCountryData();
});



</script>

<style></style>
