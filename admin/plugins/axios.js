import axios from "axios";
export default defineNuxtPlugin((NuxtApp) => {
	//https://dev-api.futuregenit.com/api/
 //const baseURL = 'https://api.totomonkey.com/api/'; //"http://127.0.0.1:8000/api/";  
 const baseURL = process.env.NODE_ENV === 'production' ? 'https://api.liquidcointrading.com/api/' :  'http://127.0.0.1:8000/api/';  
  axios.defaults.baseURL = baseURL;
  axios.defaults.withCredentials = false;
  axios.defaults.proxyHeaders = false;
  if (process.client) {
    const token = window.localStorage.getItem("token");
    if (token) {
      axios.defaults.headers.common["Authorization"] = "Bearer " + token;
    }
  }
  return {
    provide: {
      axios: axios,
    },
  };
});
