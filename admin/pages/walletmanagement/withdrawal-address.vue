<template>
  <title>Withdrawal Address List</title>
  <div>
    <div class="content-wrapper">
      <section class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <p>Show All Users Withdrawal Address</p>
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
                  <div class="col-lg-8 col-md-10 col-sm-12 mb-2">
                    <input type="text" v-model="searchQuery" class="form-control" placeholder="Search by username..." />
                  </div>



                  <div class="col-lg-2 col-md-2 col-sm-6 mb-2">
                    <button @click="filterData()" class="btn btn-primary w-100">
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
              <table class="table w-100 table-wrapper">
                <thead>
                  <tr>
                    <th class="text-left">SL</th>
                    <th class="text-left">User Info</th>
                    <th class="text-left">Type</th>
                    <th class="text-left">Payment Info</th>
                    <th class="text-center">Created Date</th>
                    <!-- <th class="text-center">Action</th> -->
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(pro, index) in productdata" :key="index">
                    <td class="text-left">{{ index + 1 }}</td>
                    <td class="text-left">
                      <small>UserName: {{ pro.username }}</small><br />
                      <small>Email: {{ pro.email }}</small><br />
                    </td>
                    <td class="text-left">{{ pro.type }}</td>




                    <td class="text-left">
                      <span v-if="pro.pay_type == 'crypto'">
                        {{ pro.coinName }}<br />
                        {{ pro.wallet_address }}
                      </span>
                      <span v-if="pro.pay_type == 'banking'">
                        {{ pro.selected_bank }}<br />
                        {{ pro.selected_bank }}<br />
                        {{ pro.bankAccountName }}<br />
                        {{ pro.bankAccountNum }}
                      </span>

                      <span v-if="pro.pay_type == 'mobile_banking'">
                        {{ pro.mobile_bank_country }}<br />
                        {{ pro.mobileBanking }}<br />
                        {{ pro.mobileaccountNumber }} 
                      </span>
                    </td>


                    <td class="text-center">{{ pro.created_at }}</td>

                    <!-- <td>
                        <center>
                          <span @click="deleteRow(pro.id)"><button class="w-50"><i class="fa fa-trash" aria-hidden="true"></i></button></span>
                        </center>
                      </td> -->
                  </tr>
                </tbody>
                <tfoot>
                  <tr>
                    <th class="text-left">SL</th>
                    <th class="text-left">User Info</th>
                    <th class="text-left">Type</th>
                    <th class="text-left">Payment Info</th>
                    <th class="text-center">Created Date</th>
                    <!-- <th class="text-center">Action</th> -->
                  </tr>
                </tfoot>
              </table>
              <center>
                <div class="pagination" style="text-align: center">
                  <button :disabled="currentPage === 1" @click="fetchData(currentPage - 1)">
                    Previous
                  </button>
                  <template v-for="pageNumber in displayedPages" :key="pageNumber">
                    <button @click="fetchData(pageNumber)">
                      {{ pageNumber }}
                    </button>
                  </template>
                  <button :disabled="currentPage === totalPages" @click="fetchData(currentPage + 1)">
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
    </div>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from "vue";
import axios from "axios";

import Swal from "sweetalert2"

definePageMeta({
  middleware: "is-logged-out",
});

const router = useRouter();
const loading = ref(false);
const currentPage = ref(1);
const pageSize = 100;
const totalRecords = ref(0);
const totalPages = ref(0);
const productdata = ref([]);
const searchQuery = ref(""); // Add a ref for the search query
const selectedFilter = ref(null); // Add a ref for the search query
// Define a method to handle editing
const deleteRow = (id) => {
  Swal.fire({
    title: "Are you sure?",
    text: "You won't be able to revert this!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, delete it!"
  }).then((result) => {
    if (result.isConfirmed) {

      try {
        const response = axios.get(`/withdrawal/walletAddresslist`, {
          params: {
            id: id,
          },
        });
        console.log(response.data)
        //productdata.value = response.data.data;
        filterData();
        Swal.fire({
          title: "Deleted!",
          text: "Your record has been deleted.",
          icon: "success"
        });
      } catch (error) {
        // Handle error
      }


    }
  });

}



const fetchData = async (page) => {
  try {
    loading.value = true;
    const response = await axios.get(`/withdrawal/walletAddresslist`, {
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