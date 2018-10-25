<template>
  <div class="app-view">
    <vs-navbar v-model="activeItem" class="nabarx">
      <!-- <vs-button vs-type="flat" vs-radius="50%" vs-icon="menu"></vs-button> -->

      <vs-navbar-title>
        ねこですProject.
      </vs-navbar-title>

      <vs-navbar-item index="0">
        <a href="#">Home</a>
      </vs-navbar-item>
      <vs-navbar-item index="1">
        <a href="#">News</a>
      </vs-navbar-item>

      <vs-spacer></vs-spacer>
      <vs-navbar-item>
        <a href="#">Login</a>
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
    return ({
      common: {
        test: 1
      },
      activeItem: 0
    })
  }
}
</script>

<style lang="stylus">
@import 'vuesax/dist/vuesax.css'
</style>