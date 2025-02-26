<template>
    <title>Short Video List</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Short Video List ({{ totalRecords }})</p>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <LazyNuxtLink to="/admin/dashboard">Home</LazyNuxtLink>
                                </li>
                                <li class="breadcrumb-item active">
                                    <LazyNuxtLink to="/post/shortvideo/add">New</LazyNuxtLink>
                                </li>
                            </ol>
                        </div>
                    </div>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-lg-8 col-md-8 col-sm-12 mb-2">
                                    <input type="text" v-model="searchQuery" class="form-control"
                                        placeholder="Search ID" />
                                </div>

                                <div class="col-lg-2 col-md-2 col-sm-6 mb-2">
                                    <select v-model="selectedFilter" class="form-control" @change="filterData">
                                        <option value="1">Active</option>
                                        <option value="0">Inactive</option>
                                    </select>
                                </div>

                                <div class="col-lg-2 col-md-2 col-sm-6 mb-2">
                                    <button @click="filterData()" class="btn btn-primary w-100">Filter</button>
                                </div>
                            </div>

                            <br />

                            <div class="card">
                                <div class="loading-indicator" v-if="loading" style="text-align: center;">
                                    <Loader />
                                </div>
                                <div class="card-body">
                                    <div>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <!-- Loop through productdata and display each video in a column -->
                                                <div v-for="(item, index) in productdata" :key="item.id"
                                                    class="col-12 col-md-4 col-lg-2 mb-4">
                                                    <video v-if="item.files" :src="item.files" controls
                                                        class="video-fluid" style="width: 100%; height: auto;">
                                                    </video>



                                                    <span v-if="item.status == 1">
                                                        <button @click="deleteVideo(item.id, 0)"
                                                            class="btn btn-danger mt-2 w-100">
                                                            Delete[{{ item.id }}]
                                                        </button>

                                                    </span>

                                                    <span v-if="item.status == 0">
                                                        <button @click="deleteVideo(item.id, 1)"
                                                            class="btn btn-success mt-2 w-100">
                                                            Active [{{ item.id }}]
                                                        </button>


                                                    </span>

                                                </div>
                                            </div>
                                        </div>






                                        <center>
                                            <div class="pagination" style="text-align: center">
                                                <button :disabled="currentPage === 1"
                                                    @click="fetchData(currentPage - 1)">
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
                </div>
            </section>
        </div>
    </div>
</template>
<script setup>
import { ref, watch, onMounted } from "vue";
import axios from "axios";
definePageMeta({
    middleware: 'is-logged-out',
    title: 'Profile' // Set your desired page title here

})

import swal from 'sweetalert2';
window.Swal = swal;

const router = useRouter();
const loading = ref(false);
const currentPage = ref(1);
const pageSize = 10;
const totalRecords = ref(0);
const totalPages = ref(0);
const productdata = ref([]);
const searchQuery = ref(""); // Add a ref for the search query
const selectedFilter = ref(1); // Add a ref for the search query
const chunkedProductData = ref([]); // Declare chunkedProductData as a reactive variable

const fetchData = async (page) => {
    try {
        loading.value = true;

        // Make the API call to fetch data
        const response = await axios.get(`/post/allShortVideoPost`, {
            params: {
                page: page,
                pageSize: pageSize,
                searchQuery: searchQuery.value, // Pass the search query parameter
                selectedFilter: selectedFilter.value, // Pass the filter parameter
            },
        });
        //console.log("=====" + response.data.data);
        // Update product data with the response
        productdata.value = response.data.data;
        totalRecords.value = response.data.total_records;
        totalPages.value = response.data.total_pages;
        currentPage.value = response.data.current_page;

        // Chunk the product data into rows of 5 items
        // chunkedProductData.value = chunkArray(productdata.value, 5);

    } catch (error) {
        // Handle any errors here
        console.error("Error fetching data:", error);
    } finally {
        loading.value = false;
    }
};



onMounted(() => {
    fetchData(currentPage.value);
});


watch(currentPage, (newPage) => {
    fetchData(newPage);
});

// Define a method to handle deleting
const deleteVideo = async (id, status) => {
    // Show SweetAlert confirmation
    let result;
    if (status == 1) {

        result = await Swal.fire({
            title: 'Are you sure?',
            text: 'Do you want to active this video?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, Active!',
            cancelButtonText: 'No, cancel!',
        });


    }

    if (status == 0) {

        result = await Swal.fire({
            title: 'Are you sure?',
            text: 'Do you want to delete this video?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'No, cancel!',
        });
    }

    if (result.isConfirmed) {
        try {
            // Proceed with the deletion
            const params = {
                id: id,
                status: status
            };
            const response = await axios.get('/post/deleteShorVidoes', { params });
            if (response.data) {
                fetchData(currentPage.value);
                if (status == 1) {
                    Swal.fire('Active !', 'The video has been Active.', 'success');
                }

                if (status == 0) {
                    Swal.fire('Deleted!', 'The video has been deleted.', 'success');
                }



            } else {
                Swal.fire('Error!', 'Failed to delete the video.', 'error');
            }
        } catch (error) {
            console.error(error);
            Swal.fire('Error!', 'An error occurred while deleting the video.', 'error');
        }
    }
};

// Define a method to handle previewing

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
.video-fluid {
    width: 100%;
    height: auto;
}

table {
    width: 100%;
    margin-top: 20px;
}

td {
    padding: 10px;
    text-align: center;
}

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
