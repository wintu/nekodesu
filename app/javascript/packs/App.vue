<template>
  <div class="app-view">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'App',

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