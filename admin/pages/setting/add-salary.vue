<template>
    <div>
        <!--start page wrapper -->
        <div class="page-wrapper">
            <div class="page-content">
                <!--breadcrumb-->
                <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
                    <div class="ps-3">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0 p-0">
                                <li class="breadcrumb-item">
                                    <router-link to="/" href="javascript:;"><i class="bx bx-home-alt"></i></router-link>
                                </li>
                                <li class="breadcrumb-item" aria-current="page">
                                    <router-link to="/setting/salary-list">Salary List</router-link>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">New Salary</li>
                            </ol>
                        </nav>
                    </div>
                </div>
                <!--end breadcrumb-->
    
                <!--end row-->
                <div class="row">
                    <div class="col-xl-12 mx-auto">
                        <div class="card border-top border-0 border-4 border-info">
                            <div class="card-body">
                                <div class="border p-4 rounded">
    
                                    <form @submit.prevent="saveData()" id="formrest" class="forms-sample" enctype="multipart/form-data">
                                        <div class="row mb-3">
                                            <label for="inputEnterYourName" class="col-sm-3 col-form-label">Packages Name</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control name" v-model="insertdata.name" placeholder="Packages Name">
                                                <span class="text-danger" v-if="errors.name">{{ errors.name[0] }}</span>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <label for="inputEnterYourName" class="col-sm-3 col-form-label">Number of Referell</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control name" v-model="insertdata.number_of_referell" placeholder="0">
                                                <span class="text-danger" v-if="errors.number_of_referell">{{ errors.number_of_referell[0] }}</span>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="inputEnterYourName" class="col-sm-3 col-form-label">Number of Sales</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control name" v-model="insertdata.number_of_sales" placeholder="0">
                                                <span class="text-danger" v-if="errors.number_of_sales">{{ errors.number_of_sales[0] }}</span>
                                            </div>
                                        </div>


                                        <div class="row mb-3">
                                            <label for="inputEnterYourName" class="col-sm-3 col-form-label">Number of Blogs</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control name" v-model="insertdata.number_of_blogs" placeholder="0">
                                                <span class="text-danger" v-if="errors.number_of_blogs">{{ errors.number_of_blogs[0] }}</span>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="inputEnterYourName" class="col-sm-3 col-form-label">Salary Amount</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control name" v-model="insertdata.salary_amount" placeholder="0">
                                                <span class="text-danger" v-if="errors.salary_amount">{{ errors.name[0] }}</span>
                                            </div>
                                        </div>


    
                                        <div class="row mb-3">
                                            <label for="inputConfirmPassword2" class="col-sm-3 col-form-label">Status</label>
                                            <div class="col-sm-9">
                                                <select name="status" v-model="insertdata.status" class="form-select">
                                                    <option value="1" selected>Active</option>
                                                    <option value="0">Inactive</option>
                                                </select>
                                            </div>
                                        </div>
    
                                        <div class="row">
                                            <label class="col-sm-3 col-form-label"></label>
                                            <div class="col-sm-9">
                                                <button type="submit" class="btn btn-success px-5 w-100"><i class="bx bx-check-circle mr-1"></i> Submit</button>
                                            </div>
                                        </div>
                                    </form>
    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--end row-->
            </div>
        </div>
        <!--end page wrapper -->
    </div>
    </template>
    
        
    <script>
    export default {
        head: {
                title: 'Add New Salary',
            },
        data() {
            return {
                insertdata: {
                    id: '',
                    name: '',
                    number_of_referell: '',
                    number_of_sales: '',
                    number_of_blogs: '',
                    salary_amount: '',
                    status: 1,
                },
                notifmsg: '',
                errors: {},
            }
        },
        created() {},
        methods: {
            saveData() {
                const formData = new FormData();
                formData.append('id', this.insertdata.id);
                formData.append('name', this.insertdata.name);

                formData.append('number_of_referell', this.insertdata.number_of_referell);
                formData.append('number_of_sales', this.insertdata.number_of_sales);
                formData.append('number_of_blogs', this.insertdata.number_of_blogs);
                formData.append('salary_amount', this.insertdata.salary_amount);

                formData.append('status', this.insertdata.status);
                const headers = {
                    'Content-Type': 'multipart/form-data'
                };
                this.$axios.post('/setting/insertSalary',
                    formData, {
                        headers
                    }).then((res) => {
                    $('#formrest')[0].reset();
                    this.success_noti();
                    this.$router.push('/setting/salary-list');
    
                }).catch(error => {
                    if (error.response.status === 422) {
                        this.errors = error.response.data.errors;
                    }
                });
            },
            success_noti() {
                Lobibox.notify('success', {
                    pauseDelayOnHover: true,
                    continueDelayOnInactiveTab: false,
                    position: 'top right',
                    icon: 'bx bx-check-circle',
                    msg: 'Your data has been successfully inserted.'
                });
            },
    
        },
    }
    </script>
    