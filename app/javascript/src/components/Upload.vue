<template>
  <div class="upload-view">
    <vs-row>
      <vs-col vs-offset="2" vs-w="8" class="input-container">
        <h1 class="title">Upload</h1>
        <div class="inputs">
          <vs-input label="タイトル" placeholder="ねこですアンケートデータ" v-model="title" class="login-input"/>
          <vs-input label="論文のリンク" placeholder="https://example.com" v-model="link" class="login-input"/>
          <vs-select
            label="カテゴリー"
            class="login-input"
            v-model="categoryId"
          >
            <vs-select-item :key="index" :value="item.id" :text="item.name" v-for="(item,index) in categoryOption" />
          </vs-select>
          <label class="vs-select--label">タグ</label>
          <vs-chips placeholder="タグを入力し、Enterを押してください。" v-model="tags">
            <vs-chip
              :key="tag"
              @click="remove(tag)"
              v-for="tag in tags" closable>
              {{ tag }}
            </vs-chip>
          </vs-chips>
          <vs-textarea label="データの説明" v-model="description" class="login-input" />
        </div>
      </vs-col>
    </vs-row>

    <vs-row>
      <vs-col vs-offset="2" vs-w="8" class="input-container">
        <input type="file" @change="selectFile" accept="text/csv">
      </vs-col>
    </vs-row>

    <vs-row v-if="uploadFile && targetLabel">
      <vs-col vs-offset="2" vs-w="4" vs-type="flex" vs-justify="center" vs-align="center" >
        <vs-select
          label="表示方法"
          class="login-input"
          v-model="displayType"
        >
          <vs-select-item :key="index" :value="item.id" :text="item.name" v-for="(item,index) in displayTypes" />
        </vs-select>
      </vs-col>

      <vs-col vs-w="4" vs-type="flex" vs-justify="center" vs-align="center" >
        <vs-select
          label="指標になる項目"
          class="login-input"
          v-model="targetLabel"
          :disabled="this.displayType === 0"
        >
          <vs-select-item :key="index" :value="item" :text="item" v-for="(item,index) in fileHeaders" />
        </vs-select>
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
      link: '',
      categoryId: undefined,
      tags: [],
      categoryOption: [
        { name: '選択してください。', id: undefined }
      ],
      displayType: 0,
      displayTypes: [
        { id: 0, name: '表' },
        { id: 1, name: '棒グラフ' }
      ],
      targetLabel: '',
      fileHeaders: []
    }
  },

  async created() {
    await this.fetchCategory()
  },
  
  methods: {
    selectFile (e) {
      e.preventDefault()
      this.uploadFile = e.target.files[0]
      this.uploadFileHeaders()
    },

    uploadFileHeaders() {
      const vm = this
      const reader = new FileReader()
      reader.onload = function(e) {
        vm.fileHeaders = e.target.result.split(/\n/)[0].split(',')
        vm.targetLabel = vm.fileHeaders[0]
      }
      reader.readAsText(this.uploadFile)
    },

    async send() {
      const params = new FormData()
      params.append('upload_file', this.uploadFile)
      params.append('title', this.title)
      params.append('description', this.description)
      params.append('link', this.link)
      params.append('category_id', this.categoryId)
      params.append('tags', this.tags.join(','))
      params.append('target_label', this.targetLabel)
      params.append('display_type', this.displayType)
      const res = await this.ApiPost('/api/file/upload', params)
      if (!res.ok) {
        this.$vs.notify({color:'danger',title:'アップロード失敗',text: '適切なフォーマットかどうかを確認お願いします。'})
        return
      }
      this.$vs.notify({color:'success',title:'アップロード成功',text: `ファイルは正常に登録されました！ 協力に感謝します！！`})
      this.$router.push(`/details/${res.data_set_id}`)
      
    },

    remove(tag) {
      const tagIdx = this.tags.findIndex(t => t === tag)
      this.tags.splice(tagIdx, 1)
    },

    async fetchCategory() {
      const res = await this.ApiGet('/api/suggest/category')
      if (res.error) return
      this.categoryOption.push(...res)
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

