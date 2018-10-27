<template>
  <div class="register-view">
    <vs-row>
      <vs-col vs-offset="2" vs-w="8" class="input-container">
        <h1 class="title">REGISTER</h1>
        <div class="inputs">
          <vs-input vs-label="Name" vs-placeholder="Placeholder" v-model="name" class="login-input"/>
          <vs-input vs-label="Email" vs-placeholder="Placeholder" type="email" v-model="email" class="login-input"/>
          <vs-input vs-label="Password" type="password" vs-placeholder="Placeholder" v-model="password" class="login-input"/>
        </div>
      </vs-col>
    </vs-row>

    <vs-row>
      <vs-col vs-offset="2" vs-w="8" vs-type="flex" vs-justify="center" vs-align="center" class="buttons">
        <vs-button vs-type="relief" vs-size="large" @click="send()">新規登録</vs-button>
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
      name: '',
      email: '',
      password: ''
    }
  },

  created() {
    console.log(this.common)
    if (this.common.loginUser) {
      this.$vs.notify({color:'success',title:'ログイン済み',text: '既にログイン済みです。'})
      this.$router.push('/')
    }
  },

  methods: {
    async send() {
      const res = await this.ApiPost('/api/user/create', {
        name: this.name,
        email: this.email,
        password: this.password
      })
      if (!res.ok) {
        this.$vs.notify({color:'danger',title:'エラー',text: 'アカウントの作成に失敗しました。'})
        return
      }
      this.common.loginUser = res
      this.$vs.notify({color:'success',title:'ログイン成功',text: `ようこそ${res.name}さん！`})
      this.$router.push('/')
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


