<template>
  <div class="login-view">
    <vs-row>
      <vs-col vs-offset="2" vs-w="8" class="input-container">
        <h1 class="title">LOGIN</h1>
        <div class="inputs">
          <vs-input vs-label="Email" vs-placeholder="Placeholder" type="email" v-model="email" class="login-input"/>
          <vs-input vs-label="Password" type="password" vs-placeholder="Placeholder" v-model="password" class="login-input"/>
        </div>
      </vs-col>
    </vs-row>

    <vs-row>
      <vs-col vs-offset="2" vs-w="8" vs-type="flex" vs-justify="center" vs-align="center" class="buttons">
        <vs-button vs-type="relief" vs-size="large" @click="send()">ログイン</vs-button>
        <vs-button vs-type="relief" color="success" vs-size="large" @click="jump()" class="register-button">新規登録</vs-button>
      </vs-col>
    </vs-row>
  </div>
</template>

<script>
export default {
  name: 'Login',
  props: ['common'],

  data() {
    return {
      email: '',
      password: ''
    }
  },

  created() {
    if (this.common.isLogin) {
      this.$vs.notify({color:'success',title:'ログイン済み',text: '既にログイン済みです。'})
      this.$router.push('/')
    }
  },

  methods: {
    async send() {
      const res = await this.ApiPost('/api/user/login', {
        email: this.email,
        password: this.password
      })
      if (!res.ok) {
        this.$vs.notify({color:'danger',title:'ログイン失敗',text: 'パスワードとIDをもう一度お確かめください。'})
        return
      }
      this.common.loginUser = res
      this.common.isLogin = true
      this.$vs.notify({color:'success',title:'ログイン成功',text: `ようこそ${res.name}さん！`})
      this.$router.push('/')
    },

    jump() {
      this.$router.push('/register')
    }
  }
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
    .buttons
      margin 20px 0
    .register-button
      margin-left 10px


</style>


