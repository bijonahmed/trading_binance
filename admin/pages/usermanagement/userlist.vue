<template>
  <title>User List</title>
  <div>
    <div class="content-wrapper">
      <section class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <p>User List</p>
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

      <!-- Main content -->
      <!-- Main content -->
      <section class="content">
        <div class="container-fluid">
          <div class="page_top my-2">
            <div class="row justify-content-between align-items-center my-2">
              <div class="col-md-6">
                <form action="">
                  <table class="table mb-0">
                    <thead>
                      <tr>
                        <th
                          class="border-0 p-0"
                          style="padding-right: 5px !important"
                        >
                          <input
                            type="text"
                            class="form-control"
                            v-model="searchQuery"
                            placeholder="Search by email "
                          />
                        </th>
                        <th
                          class="border-0 p-0 me-1"
                          style="padding-right: 5px !important"
                        >
                          <select
                            name=""
                            id=""
                            class="form-control"
                            v-model="selectedFilter"
                            @change="filterData"
                          >
                            <option value="" selected disabled>
                              Select status
                            </option>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                          </select>
                        </th>
                        <th class="border-0 p-0 h-100">
                          <button
                            type="button"
                            style="min-width: 90px"
                            @click="filterData()"
                            class="btn btn-primary btn-fla"
                          >
                            <i class="fas fa-search"></i>Search
                          </button>
                        </th>
                      </tr>
                    </thead>
                  </table>
                </form>
              </div>
             
            </div>
          </div>

          <!-- table section start here  -->
          <div class="card">
            <div class="card-body table-responsive p-0">
              <div class="filter_options">
                <div
                  class="loading-indicator"
                  v-if="loading"
                  style="text-align: center"
                >
                  <Loader />
                </div>
              </div>
              <table class="table table-hover text-nowrap">
                <thead>
                  <tr>
                    <th><input type="checkbox" id="checkAll" /></th>
                    <th>User ID</th>
                    <th class="text-start">User Info</th>
                    <th>Status</th>
                    <th class="text-start">Invite users</th>
                    <th style="text-align: left;">Balance</th>
                    <th style="text-align: left;">Register IP</th>
                    <th style="text-align: left;">Reg/Update time</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in productdata" :key="item.id">
                    <td>
                      <input type="checkbox" class="checkBox" />
                    </td>
                    <td>{{ item.id }}</td>
                    <td class="text-left">
                      <small>{{ item.userInfo_1 }}</small
                      ><br />
                      <small>{{ item.userInfo_2 }}</small
                      ><br />
                      <small>{{ item.userInfo_3 }}</small
                      ><br />
                    </td>
                    <td>
                      <small>{{ item.status }}</small>
                    </td>
                    <td class="text-left">
                      <small>{{ item.invite_user_1 }}</small
                      ><br />
                      <small>{{ item.invite_user_2 }}</small
                      ><br />
                      <small>{{ item.invite_user_3 }}</small
                      ><br />
                    </td>
                    <td style="text-align: center;">
                      <p><b>{{ item.currentBalance }}</b></p>
                    </td>
                   
                    <td style="text-align: center;">
                      <p>{{ item.register_ip }}</p>
                      <p>{{ item.register_country }}</p>
                    </td>
                   
                    <td>
                      <p>R: {{ item.created_at }}</p>
                      <p>U: {{ item.updated_at }}</p>
                    </td>
                    <td>
                      <div class="">
                        <!-- <button
                          class="btn w-100 d-block btn-default btn-sm btn-flat"
                          @click="getDetails(item.id)"
                        >
                          <i class="far fa-eye"></i>Details
                        </button> -->
                        <button
                          class="btn w-100 btn-warning btn-sm btn-flat"
                          @click="edit(item.id)"
                        >
                          <i class="fas fa-pen"></i>Edit
                        </button>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>

              <center>
                <div class="pagination" style="text-align: center">
                  <button
                    :disabled="currentPage === 1"
                    @click="fetchData(currentPage - 1)"
                  >
                    Previous
                  </button>
                  <template
                    v-for="pageNumber in displayedPages"
                    :key="pageNumber"
                  >
                    <button @click="fetchData(pageNumber)">
                      {{ pageNumber }}
                    </button>
                  </template>
                  <button
                    :disabled="currentPage === totalPages"
                    @click="fetchData(currentPage + 1)"
                  >
                    Next
                  </button>
                </div>
              </center>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- table section end here  -->
        </div>
      </section>
      <!-- /.content -->
      <!-- /.content -->
    </div>

    <!-- Start Modal  -->
    <!-- details modal  -->
    <div
      class="modal fade"
      id="details"
      tabindex="-1"
      role="dialog"
      aria-labelledby="detailsTitle"
      aria-hidden="true"
    >
      <div
        class="modal-dialog modal-dialog-scrollable modal-lg"
        role="document"
      >
        <div class="modal-content">
          <div class="modal-header py-1">
            <h5 class="modal-title" id="detailsTitle">Details</h5>
            <button
              type="button"
              class="close"
              data-dismiss="modal"
              aria-label="Close"
            >
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <center>
              <b>Maximum Supply:</b> {{ maximum_supply }} UIC |
              <b>Total Supply:</b> {{ total_supply }} UIC |
              <b>Circulating Supply:</b> {{ circulatingSupply }} UIC |
              <b>Market Cap:</b> {{ marketCap }} | Current Price
              {{ currentPrice_top }} USDT
            </center>

            <table class="table">
              <tr>
                <td class="text-left">User ID</td>
                <td class="text-left">{{ u_details_user_id }}</td>
              </tr>

              <tr>
                <td class="text-left">UIC Balance</td>
                <td class="text-left" style="color: blue; font-size: 18px">
                  <strong>{{ uic_amount }}</strong>
                </td>
              </tr>

              <tr>
                <td class="text-left">USDT Balance</td>
                <td class="text-left" style="color: blue; font-size: 18px">
                  <strong>${{ usdt_amount }}</strong>
                </td>
              </tr>

              <tr style="color: green; font-size: 15px">
                <td class="text-left">Total Successfull Deposit (+)</td>
                <td class="text-left">{{ total_success_deposit }}</td>
              </tr>

              <tr style="color: red; font-size: 15px">
                <td class="text-left">Total Successfull Withdraw (-)</td>
                <td class="text-left">{{ total_success_withdraw }}</td>
              </tr>

              <tr style="color: darkorange; font-size: 15px">
                <td class="text-left">Total Airdrop</td>
                <td class="text-left">{{ total_airdrop }}</td>
              </tr>

              <tr style="color: green; font-size: 15px">
                <td class="text-left">New Member Register Bonus (+)</td>
                <td class="text-left">{{ register_bonus }}</td>
              </tr>

              <tr style="color: green; font-size: 15px">
                <td class="text-left">Total Commission (+)</td>
                <td class="text-left">{{ total_commission }}</td>
              </tr>

              <tr style="color: green; font-size: 15px">
                <td class="text-left">Total Reward UIC (+)</td>
                <td class="text-left">{{ adj_type_sum }}</td>
              </tr>

              <tr style="color: red; font-size: 15px">
                <td class="text-left">Total Reward UIC (-)</td>
                <td class="text-left">{{ adj_type_minus }}</td>
              </tr>
              <tr style="color: red; font-size: 15px">
                <td class="text-left">Total Buy Mining Machine Expense (-)</td>
                <td class="text-left">{{ total_expense }}</td>
              </tr>

              <!-- <tr  style="color:darkorange; font-size: 15px;">
                                <td class="text-left">Total Frozen amount (-)</td>
                                <td class="text-left">{{ u_details_frozenAmount }}</td>
                            </tr> -->

              <tr>
                <td class="text-left">User type</td>
                <td class="text-left">{{ u_details_rulename }}</td>
              </tr>
              <tr>
                <td class="text-left">User Info</td>
                <td class="text-left" style="padding: 5px">
                  <small>Name&nbsp;:&nbsp;{{ u_details_userInfo_1 }}</small
                  ><br />
                  <!-- <small>Phone&nbsp;:&nbsp;{{ u_details_userInfo_2 }}</small
                  ><br /> -->
                  <small>Email&nbsp;:&nbsp;{{ u_details_userInfo_3 }}</small
                  ><br />
                  <small>Telegram&nbsp;:&nbsp;{{ u_details_userInfo_4 }}</small
                  ><br />
                  <small>WhatsApp&nbsp;:&nbsp;{{ u_details_userInfo_5 }}</small
                  ><br />
                </td>
              </tr>
              <tr>
                <td class="text-left">Status</td>
                <td class="text-left">{{ u_details_status }}</td>
              </tr>
              <tr>
                <td class="text-left">Invite users</td>
                <td class="text-left">
                  <img
                    src="/images/avatar.png"
                    width="20px"
                    alt=""
                    class="img-fluid"
                  />
                  <small>{{ u_details_invite_user_1 }}</small
                  ><br />
                  <small>{{ u_details_invite_user_2 }}</small
                  ><br />
                  <small>{{ u_details_invite_user_3 }}</small
                  ><br />
                </td>
              </tr>

              <!-- <tr>
                                <td class="text-left">KYC Verification</td>
                                <td class="text-left">
                                    <img :src="u_details_kyc" alt="" class="img-fluid" style="height: 100%;width: 250px;">
                                </td>
                            </tr> -->

              <tr>
                <td class="text-left">Register/Login IP</td>
                <td class="text-left">
                  <p>Registration: {{ u_details_register_ip }}</p>
                  <p>Login: {{ u_details_lastlogin_ip }}</p>
                </td>
              </tr>
              <!-- <tr>
                                <td class="text-left">Register/login IP country</td>
                                <td class="text-left">
                                    <p>Registration: {{ u_details_register_country }}</p>
                                    <p>Login: {{ u_details_lastlogin_country }}</p>
                                </td>
                            </tr> -->
              <tr>
                <td class="text-left">Registration time</td>
                <td class="text-left">
                  <small>{{ u_details_created_at }}</small>
                </td>
              </tr>
              <tr>
                <td class="text-left">Update time</td>
                <td class="text-left">
                  <small>{{ u_details_updated_at }}</small>
                </td>
              </tr>
            </table>
            <hr />
       
          </div>
        </div>
      </div>
    </div>
    <!-- start operation modal start here  -->
  

    <!-- team show modal  -->
    
    <!-- delete modal  -->
  
    <!-- END Modal  -->
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from "vue";
import axios from "axios";
import { useUserStore } from "~~/stores/user";
import swal from "sweetalert2";
definePageMeta({
  middleware: "is-logged-out",
  title: "User List", // Set your desired page title here
});
const router = useRouter();
const loading = ref(false);
const currentPage = ref(1);
const pageSize = 10;
const totalRecords = ref(0);
const totalPages = ref(0);
const productdata = ref([]);
const searchQuery = ref(""); // Add a ref for the search query
const selectedFilter = ref(1); // Add a ref for the search query
const deleteuserId = ref(); // Add a ref for the search query
// UserDetails Information
const u_details_user_id = ref("");
const u_details_name = ref("");
const u_details_rulename = ref("");
const u_details_userInfo_1 = ref("");
const u_details_userInfo_2 = ref("");
const u_details_userInfo_3 = ref("");
const u_details_userInfo_4 = ref("");
const u_details_userInfo_5 = ref("");
const u_details_invite_user_1 = ref("");
const u_details_invite_user_2 = ref("");
const u_details_invite_user_3 = ref("");
const u_details_email = ref("");
const u_details_register_ip = ref("");
const u_details_lastlogin_ip = ref("");
const u_details_register_country = ref("");
const u_details_lastlogin_country = ref("");
const u_details_created_at = ref("");
const u_details_updated_at = ref("");
const u_details_phone_number = ref("");
const u_details_show_password = ref("");

const u_details_status = ref("");
const u_details_avail_balance = ref("");
const u_details_frozenAmount = ref("");
const u_details_kyc = ref("");

const total_success_deposit = ref(0);
const total_success_withdraw = ref(0);
const total_profit = ref(0);
const total_commission = ref(0);
const total_redward_plus = ref(0);
const total_redward_minus = ref(0);
const total_expense = ref(0);
const total_processing_withdraw = ref(0);
const uic_amount = ref(0);
const usdt_amount = ref(0);
const total_airdrop = ref(0);
const register_bonus = ref(0);

const adj_type_sum = ref(0);
const adj_type_minus = ref(0);

const marketCap = ref(0);
const currentPrice_top = ref(0);
const maximum_supply = ref(0);
const total_supply = ref(0);
const circulatingSupply = ref(0);
const swap_tran = ref([]);

//END userDetails Information

const fetchData = async (page) => {
  try {
    loading.value = true;
    const response = await axios.get(`/user/allUsers`, {
      params: {
        page: page,
        pageSize: pageSize,
        searchQuery: searchQuery.value, // Pass the search query parameter
        selectedFilter: selectedFilter.value, // Pass the search query parameter
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

const logoutUsers = async () => {
  try {
    // Call the server-side logout endpoint
    await axios.post("/logout/all");
    // Clear JWT token from local storage or wherever it's stored
    //await userStore.logout();
    localStorage.removeItem("token");
    success_noti();
    //localStorage.removeItem('token');
    // Redirect to the login page
    router.push("/");
  } catch (error) {
    console.error("Error logging out all devices:", error);
  }
};

const success_noti = () => {
  const Toast = swal.mixin({
    toast: true,
    position: "top-end",
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
      toast.onmouseenter = swal.stopTimer;
      toast.onmouseleave = swal.resumeTimer;
    },
  });
  Toast.fire({
    icon: "success",
    title: "Successfull Logout All Users Status.",
  });
};

const getDetails = (id) => {
  loading.value = true;
  $("#details").modal("show");
  axios
    .get(`/user/findUserDetails`, {
      params: {
        id: id,
      },
    })
    .then((response) => {
      // Handle successful response here
      u_details_user_id.value = response.data.user_id;
      u_details_name.value = response.data.name;
      u_details_rulename.value = response.data.rulename;
      u_details_userInfo_1.value = response.data.userInfo_1;
      u_details_userInfo_2.value = response.data.userInfo_2;
      u_details_userInfo_3.value = response.data.userInfo_3;
      u_details_userInfo_4.value = response.data.userInfo_4;
      u_details_userInfo_5.value = response.data.userInfo_5;
      u_details_invite_user_1.value = response.data.invite_user_1;
      u_details_invite_user_2.value = response.data.invite_user_2;
      u_details_invite_user_3.value = response.data.invite_user_3;
      u_details_email.value = response.data.email;
      u_details_register_ip.value = response.data.register_ip;
      u_details_lastlogin_ip.value = response.data.lastlogin_ip;
      u_details_register_country.value = response.data.register_country;
      u_details_lastlogin_country.value = response.data.lastlogin_country;
      u_details_created_at.value = response.data.created_at;
      u_details_updated_at.value = response.data.updated_at;
      u_details_phone_number.value = response.data.phone_number;
      u_details_show_password.value = response.data.show_password;
      u_details_status.value = response.data.status;
      u_details_avail_balance.value = response.data.u_details_avail_balance;
      u_details_frozenAmount.value = response.data.u_details_frozenAmount;
      u_details_kyc.value = response.data.u_details_kyc;
      //caculation
      total_success_deposit.value = response.data.total_success_deposit;
      total_success_withdraw.value = response.data.total_success_withdraw;
      total_processing_withdraw.value = response.data.total_processing_withdraw;
      total_profit.value = response.data.total_profit;
      total_commission.value = response.data.total_commission;
      total_redward_plus.value = response.data.total_redward_plus;
      total_expense.value = response.data.total_expense;
      total_redward_minus.value = response.data.total_redward_minus;
      uic_amount.value = response.data.uic_amount;
      usdt_amount.value = response.data.usdt_amount;
      total_airdrop.value = response.data.total_airdrop;
      register_bonus.value = response.data.register_bonus;
      adj_type_sum.value = response.data.adj_type_sum;
      adj_type_minus.value = response.data.adj_type_minus;

      marketCap.value = response.data.marketCap;
      currentPrice_top.value = response.data.currentPrice_top;
      maximum_supply.value = response.data.maximum_supply;
      total_supply.value = response.data.total_supply;
      circulatingSupply.value = response.data.circulatingSupply;
      swap_tran.value = response.data.swap_tran;
    })
    .catch((error) => {
      // Handle errors here
      console.error("Error:", error);
    })
    .finally(() => {
      // This block will always execute, regardless of whether the request was successful or not
      loading.value = false;
      console.log("Request finished");
    });

  //u_details_user_id.value = response.id;
  // alert(id);
};

const edit = (id) => {
  router.push({
    path: "/usermanagement/useredit",
    query: {
      parameter: id,
    },
  });
  // Your logic for editing goes here
  console.log("Editing item with id:", id);
};

// Define a method to handle editing
const changePass = (id) => {
  router.push({
    path: "/user/changePassword",
    query: {
      parameter: id,
    },
  });
  // Your logic for editing goes here
  console.log("Change Password id:", id);
};

const confirmDelete = (deleteuserId) => {
  const userid = deleteuserId;
  axios
    .get(`/user/inactiveUser`, {
      params: {
        user_id: userid,
      },
    })
    .then((response) => {
      fetchData(1); // Reset to first page when search query changes
    })
    .catch((error) => {
      console.error("Error removing image:", error);
    });
};
// Define a method to handle deleting
const deleteItem = (id) => {
  deleteuserId.value = id;
};

// Define a method to handle previewing
const preview = (id) => {
  router.push({
    path: "/products/preview",
    query: {
      parameter: id,
    },
  });
  console.log("Previewing item with id:", id);
};

// Compute the range of displayed pages
const displayedPages = computed(() => {
  const maxDisplayedPages = 10; // Maximum number of displayed pages
  const startPage = Math.max(
    1,
    currentPage.value - Math.floor(maxDisplayedPages / 2)
  );
  const endPage = Math.min(totalPages.value, startPage + maxDisplayedPages - 1);
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
  padding: 0.2rem;
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
