<template>
    <title>
        Game Platform</title>
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <p>Game Platform List ({{ totalRecords }})</p>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <LazyNuxtLink to="/admin/dashboard">Home</LazyNuxtLink>
                                </li>
                                <li class="breadcrumb-item active">
                                    <LazyNuxtLink to="/game/platform/add">New</LazyNuxtLink>
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
                                <div class="col-lg-6 col-md-6 col-sm-12 mb-2">
                                    <input type="text" v-model="searchQuery" class="form-control" placeholder="Search By Name" />
                                </div>
    
    
    
                                <div class="col-lg-2 col-md-2 col-sm-6 mb-2">
                                    <select v-model="game_type_id" class="form-control" @change="filterData">
                                                              <option selected value="">Select Game Type</option>
                                                                <option v-for="(gameType, index) in selectedGameType"
                                                                    :key="gameType.id" :value="gameType.id">{{ gameType.name }}
                                                                </option>
                                                            </select>
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
    
                                        <table class="table w-100 table-wrapper">
                                            <thead>
                                                <tr>
                                                    <th class="text-left">SL NO</th>
                                                    <th class="text-left">Game Type</th>
                                                    <th class="text-left">Platform Name</th>
                                                    <th class="text-center">Images</th>
                                                    <th class="text-center">Status</th>
                                                    <th class="text-center">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr v-for="(item,index) in productdata" :key="item.id">
                                                    <td class="text-left">{{ index+1 }}</td>
                                                    <td class="text-left">{{ item.gametypeName }}</td>
                                                    <td class="text-left">{{ item.name }}</td>
                                                    <td class="text-center">
                                                        <img :src="item.image ? item.image : '/avatar.png'" alt="Image" />
                                                    </td>
    
                                                    <td class="text-center">{{ item.status }} </td>
                                                    <td class="text-center">
                                                        <button type="button"><i class="fas fa-edit"
                                                                    @click="edit(item.id)"></i></button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th class="text-left">SL NO</th>
                                                    <th class="text-left">Game Type</th>
                                                    <th class="text-left">Platofrm Name</th>
                                                    <th class="text-center">Images</th>
                                                    <th class="text-center">Status</th>
                                                    <th class="text-center">Action</th>
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
const router = useRouter();
const loading = ref(false);
const currentPage = ref(1);
const pageSize = 100;
const totalRecords = ref(0);
const game_type_id = ref("");
const totalPages = ref(0);
const game_type = ref('');
const selectedGameType = ref([]);
const productdata = ref([]);
const searchQuery = ref(""); // Add a ref for the search query
const selectedFilter = ref(1); // Add a ref for the search query

const fetchData = async (page) => {
    try {
        loading.value = true;
        const response = await axios.get(`/games/allGameCategoryList`, {
            params: {
                page: page,
                pageSize: pageSize,
                searchQuery: searchQuery.value, // Pass the search query parameter
                selectedFilter: selectedFilter.value,
                game_type_id: game_type_id.value,
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

const getGameTypeData = async () => {
    try {
        const response = await axios.get(`/games/allGamesTypes`);
        selectedGameType.value = response.data;

    } catch (error) {
        console.log(error);
    }
};

onMounted(() => {
    getGameTypeData();
    fetchData(currentPage.value);
});

// Watch for changes in current page and fetch data accordingly
watch(currentPage, (newPage) => {
    fetchData(newPage);
});

// Define a method to handle editing
const edit = (id) => {

    router.push({
        path: '/game/platform/edit',
        query: {
            parameter: id
        }
    });
    // Your logic for editing goes here
    console.log('Editing item with id:', id);
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
    return Array.from({ length: endPage - startPage + 1 },
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
