<template>
  <div class="top-view">

    <section class="concept">
      <h1>統計の共有をしよう！</h1>
    </section>

    <section class="search-box">
      <div class="input-box">
        <vs-select
          class="search-mode"
          v-model="searchMode"
          >
          <vs-select-item :key="index" :value="item.value" :text="item.text" v-for="(item,index) in searchOption" />
        </vs-select>
        <vs-input placeholder="検索してみよう！" v-model="search" class="search-input"/>
      </div>

      <div class="button-box">
        <vs-button color="primary" type="border" icon="search" @click="redirectSearchPage">検索</vs-button>
      </div>
    </section>
    
  </div>
</template>

<script>
export default {
  name: 'Top',
  props: ['common'],

  data() {
    return {
      search: '',
      searchMode: 'title',
      searchOption: [
        { text: 'タイトル', value: 'title' },
        { text: 'タグ', value: 'tag' },
        { text: 'カテゴリー', value: 'category' }
      ]
    }
  },

  methods: {
    redirectSearchPage() {
      this.$router.push(`/search?mode=${this.searchMode}&q=${this.search}`)
    }
  }
}
</script>

<style lang="stylus">
  .top-view
    .search-box
      width 100%
      position relative
      height 100vh
    .input-box
      position relative
      width 80%
      margin-top 30vh
      display flex
      justify-content center
      margin-left auto
      margin-right auto
      .search-mode
        width 20%
      .search-input
        width 80%
    .button-box
      width 100%
      display flex
      justify-content center
      margin-top 10px



</style>


