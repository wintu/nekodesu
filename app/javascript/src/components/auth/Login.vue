<template>
  <div class="login-view">
    <vs-row>
      <vs-col vs-offset="2" vs-w="8" class="input-container">
        <h1 class="title">LOGIN</h1>
        <div class="inputs">
          <vs-input vs-label="Email" vs-placeholder="Placeholder" class="login-input"/>
          <vs-input vs-label="Password" vs-placeholder="Placeholder" class="login-input"/>
        </div>
      </vs-col>
    </vs-row>
  </div>
</template>

<script>
export default {
  name: 'Login',
  props: ['common']
}
</script>

<style lang="stylus">
  .login-view
    .input-container
      position relative
      width 100%
      text-align center
      .title
        margin 50px
    .login-input
      width 100%
    .inputs
     text-align left


</style>


