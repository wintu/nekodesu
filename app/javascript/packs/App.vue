<template>
  <div class="app-view">
    <header :activeItem="0" />
    <router-view></router-view>
  </div>
</template>

<script>
import Header from './components/Header.vue'
export default {
  name: 'App',
  components: { Header },

  data() {
    return ({
      common: {

      }
    })
  }
}
</script>

<style lang="stylus">
@import 'vuesax/dist/vuesax.css'
</style>