<template>
  <div class="search-view">
    <section class="concept">
      <h1>検索結果</h1>
    </section>

    <section class="container" v-if="!notFound">
      <div class="search-box" v-for="(item, index) in result" :key="index">
        <router-link :to="`/details/${item.id}`" class="title">{{item.title}}</router-link>
        <p class="author">作成者: {{item.user_name}}</p>
        <p class="desc">{{item.description}}</p>
        <div class="tag">
          <vs-chip v-for="(tag, index) in item.tags" :key="index">{{tag.name}}</vs-chip>
        </div>
      </div>
    </section>

    <section class="container" v-else>
      <h2>検索結果が見つかりませんでした。</h2>
    </section>
  </div>
</template>

<script>
export default {
  name: 'Search',
  props: ['common'],

  data() {
    return {
      result: [],
      notFound: false
    }
  },

  async created() {
    this.fetchSearchResult()
  },

  methods: {
    async fetchSearchResult() {
      const res = await this.ApiGet(`/api/search/${this.$route.query.mode}?q=${this.$route.query.q}`)
      if (!res.ok) {
        this.notFound = true
        return
      }

      this.result = res.result
    }
  }
}
</script>

<style lang="stylus">
  .search-view
    .search-box
      width 100%
      padding 20px
      border solid 1px rgba(44, 62, 80, 0.3)
      border-radius 20px
      .title
        font-size 1.6rem
        font-weight bold
</style>

