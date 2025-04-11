<template>
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Sidebar -->
    <div class="sidebar">
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Render filtered menu items -->
          <li v-for="(menuItem, index) in filteredMenuItems" :key="index" :class="{ 'nav-item': true, 'menu-open': menuItem.children }">
            <router-link :to="menuItem.route ? menuItem.route : '#'" class="nav-link">
              <i :class="'nav-icon fas ' + menuItem.icon"></i>
              <p>
                {{ menuItem.label }}
                <i v-if="menuItem.children" class="right fas fa-angle-left"></i>
              </p>
            </router-link>

            <!-- Render children if present -->
            <ul v-if="menuItem.children" class="nav nav-treeview">
              <li v-for="(childItem, childIndex) in menuItem.children" :key="childIndex" class="nav-item">
                <router-link v-if="!childItem.hidden" :to="childItem.route" class="nav-link">
                  <p>{{ childItem.label }}</p>
                </router-link>
              </li>
            </ul>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import axios from "axios";

// Reactive variables for role_id and menu items
const role_id = ref(null);
const menuItems = ref([
  {
    label: "Dashboard",
    icon: "fa-home",
    route: "/admin/dashboard",
    children: null,
  },
  {
    label: "Profile",
    icon: "fa-th",
    route: "/user/my-profile",
    children: null,
  },
  {
    label: "User Management",
    icon: "fas fa-users",
    route: null,
    children: [
      { label: "Super Admin list", route: "/usermanagement/superadmin-list", hidden: false },
      { label: "Admin list", route: "/usermanagement/admin-list", hidden: false },
      { label: "User list", route: "/usermanagement/userlist", hidden: false },
      { label: "Kyc list", route: "/usermanagement/kyc/kyclist", hidden: false },
    ],
  },
  {
    label: "Trade Management",
    icon: "fas fa-users",
    route: null,
    children: [
      { label: "Trade list", route: "/walletmanagement/trade-request-management", hidden: false },
    ],
  },
  {
    label: "System settings",
    icon: "fas fa-cog",
    route: null,
    children: [
      { label: "Pre-Setting", route: "/setting/presetting", hidden: false },
      { label: "Payment Page Setting", route: "/walletmanagement/paymentsetting", hidden: false },
      { label: "Bank", route: "/setting/bank/list", hidden: false },
    ],
  },
  {
    label: "Wallet Management",
    icon: "fas fa-cog",
    route: null,
    children: [
      { label: "Deposit Request", route: "/walletmanagement/deposit-management", hidden: false },
      { label: "Withdrawal Request", route: "/walletmanagement/withdrawal-management", hidden: false },
      { label: "All Users withdrawal Address", route: "/walletmanagement/withdrawal-address", hidden: false },
   
     // { label: "Manual Adjustment report", route: "/walletmanagement/manual-adjustment-report", hidden: false },
      { label: "Create Manual adjustment", route: "/walletmanagement/manual-adjustment", hidden: false },
    ],
  },
]);

// Fetch role_id when the component is mounted
const fetchData = async () => {
  try {
    // Check if role_id is already stored in localStorage
    const storedRoleId = localStorage.getItem("role_id");
    if (storedRoleId) {
      role_id.value = parseInt(storedRoleId); // Use stored role_id
    } else {
      const response = await axios.post(`/auth/me`);
      console.log("Check Role:", response.data.role_id);
      role_id.value = response.data.role_id;
      // Store the role_id in localStorage for future use
      localStorage.setItem("role_id", response.data.role_id);
    }
  } catch (error) {
    console.log("Error fetching role:", error);
  }
};

onMounted(fetchData);

// Filter menu based on role_id
const filteredMenuItems = computed(() => {
  // Make sure role_id is available before filtering
  if (role_id.value === null) return []; // Avoid showing menu before role_id is fetched

  if (role_id.value == 3) {
    return menuItems.value.map(item => {
      if (item.children) {
        return {
          ...item,
          children: item.children.map(child => ({
            ...child,
            hidden: ["/usermanagement/superadmin-list", "/usermanagement/admin-list"].includes(child.route),
          }))
        };
      }
      return item;
    });
  }
  return menuItems.value;
});
</script>

<style>
body:not(.layout-fixed) .main-sidebar {
  min-height: 100vh;
  position: fixed;
}

.disabled {
  pointer-events: none;
  color: #ccc;
}
</style>
