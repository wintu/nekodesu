<template>
  <div class="app-view">
    <vs-navbar class="nabarx">
      <!-- <vs-button vs-type="flat" vs-radius="50%" vs-icon="menu"></vs-button> -->

      <vs-navbar-title class="logo-box">
        <img src="/icon.png" class="logo" alt="">
        SheReco
      </vs-navbar-title>

      <vs-navbar-item index="0">
        <router-link to="/">Home</router-link>
      </vs-navbar-item>
      <vs-navbar-item index="1" v-if="common.isLogin">
        <router-link to="/upload">Upload</router-link>
      </vs-navbar-item>

      <vs-spacer></vs-spacer>
      <vs-navbar-item v-if="!common.isLogin">
        <router-link to="/register">Register</router-link>
      </vs-navbar-item>
      <vs-navbar-item v-if="!common.isLogin">
        <router-link to="/login">Login</router-link>
      </vs-navbar-item>
      <vs-navbar-item v-if="common.isLogin">
        <a href="#" @click="logout">Logout</a>
      </vs-navbar-item>
    </vs-navbar>

    <!-- content -->
    <router-view :common="common"></router-view>
  </div>
</template>

<script>
export default {
  name: 'App',

  data() {
    return {
      common: {
        isLogin: window.isLogin || false,
        loginUser: undefined
      }
    }
  },

  async created() {
    await this.fetchLoginUser()
  },

  methods: {
    async fetchLoginUser() {
      if (!this.isLogin) return
      const data = await this.ApiGet('/api/user/current_login_user')
      if (!data.ok) return
      this.common.loginUser = data
    },

    logout() {
      window.isLogin = false
      this.common.isLogin = false
      this.common.loginUser = undefined
      window.location = '/api/user/logout'
    }
  }
}
</script>

<style lang="stylus">
  @import 'vuesax/dist/vuesax.css'

  .app-view
    .concept
      width 100%
      background #3498db
      padding 50px 0
      text-align center
      margin-bottom 20px
      h1
        color #fff
        font-weight bold
    .container
      width 80%
      position relative
      margin 0 auto
    .centerx
      display flex
      justify-content center
    .logo
      width 30px
    .logo-box
      display flex
      justify-content flex-start
      align-items center
</style>