<template>
  <div class="upload-view">
    <vs-row>
      <vs-col vs-offset="2" vs-w="8" class="input-container">
        <h1 class="title">Upload</h1>
        <div class="inputs">
          <vs-input vs-label="タイトル" vs-placeholder="Placeholder" v-model="title" class="login-input"/>
          <vs-input vs-label="論文のリンク" vs-placeholder="Placeholder" v-model="link" class="login-input"/>
          <vs-textarea label="データの説明" v-model="description" class="login-input" />
        </div>
      </vs-col>
    </vs-row>

    <vs-row>
      <vs-col vs-offset="2" vs-w="8" class="input-container">
        <input type="file" @change="selectFile" accept="text/csv">
      </vs-col>
    </vs-row>

    <vs-row>
      <vs-col vs-offset="2" vs-w="8" vs-type="flex" vs-justify="center" vs-align="center" class="buttons">
        <vs-button vs-type="relief" vs-size="large" @click="send()">データ登録</vs-button>
      </vs-col>
    </vs-row>
  </div>
</template>

<script>
export default {
  name: 'Upload',
  props: ['common'],

  data() {
    return {
      uploadFile: undefined,
      title: '',
      description: '',
      link: ''
    }
  },
  
  methods: {
    selectFile (e) {
      e.preventDefault()
      this.uploadFile = e.target.files[0]
      console.log(this.uploadFile)
    },

    async send() {
      const params = new FormData()
      params.append('upload_file', this.uploadFile)
      params.append('title', this.title)
      params.append('description', this.description)
      params.append('link', this.link)
      const res = await this.ApiPost('/api/file/upload', params)
      console.log(res)
      
    }
  }
}
</script>

<style lang="stylus">
  .upload-view
    .input-container
      margin 10px 0
      position relative
      width 100%
      text-align center
      .title
        margin 50px
    .login-input
      width 100%
      margin 10px 0
    .inputs
     text-align left
    .buttons
      margin 20px 0
</style>

