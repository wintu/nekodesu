<template>
  <div class="register-view">
    <vs-row>
      <vs-col vs-offset="2" vs-w="8" class="input-container">
        <h1 class="title">LOGIN</h1>
        <div class="inputs">
          <vs-input vs-label="Email" vs-placeholder="Placeholder" v-model="email" class="login-input"/>
          <vs-input vs-label="Password" type="password" vs-placeholder="Placeholder" v-model="password" class="login-input"/>
        </div>
      </vs-col>
    </vs-row>

    <vs-row>
      <vs-col vs-offset="2" vs-w="8" vs-type="flex" vs-justify="center" vs-align="center" class="buttons">
        <vs-button vs-type="relief" vs-size="large" @click="send()">ログイン</vs-button>
      </vs-col>
    </vs-row>
  </div>
</template>

<script>
export default {
  name: 'Register',
  props: ['common'],

  data() {
    return {
      email: '',
      password: ''
    }
  },

  methods: {
    async send() {
      const res = await this.ApiPost('/api/user/login', {
        email: this.email,
        password: this.password
      })
      console.log(res)
    }
  }
}
</script>

<style lang="stylus">
  .register-view
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
    .buttons
      margin 20px 0


</style>


