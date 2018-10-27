<template>
  <div class="details-view">
    <section class="concept" v-if="dataSet">
      <h1>{{dataSet.title}}</h1>
    </section>

    <div class="two-column-container">
      <div class="info-column">
        <div class="info-message">作成者: {{dataSet.user_name}}</div>
        <vs-divider/>
        <div class="info-message">カテゴリー: {{dataSet.category ? dataSet.category.name : 'なし'}}</div>
        <vs-divider/>
        <div v-if="dataSet.tags.length">
          <div class="info-message">タグ</div>
          <vs-chip v-for="(tag, index) in dataSet.tags" :key="index">{{tag.name}}</vs-chip>
          <vs-divider/>
        </div>
        <div v-if="dataSet.link">
          <div class="info-message">論文へのリンク</div>
          <a :href="dataSet.link">{{dataSet.link}}</a>
          <vs-divider/>
        </div>
        <div v-if="dataSet.description">
          <div class="info-message">説明</div>
          <div class="description">{{dataSet.description}}</div>
        </div>
        <div class="centerx">
          <vs-button color="primary" type="border" icon="arrow_downward">CSVダウンロード</vs-button>
        </div>
      </div>
      <div class="graph-column">hoi</div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Details',
  props: ['common'],

  data() {
    return {
      dataSet: undefined,
      datum: []
    }
  },

  async created() {
    await this.fetchDataSet()
    await this.fetchDatum()
  },

  methods: {
    async fetchDataSet() {
      const res = await this.ApiGet(`/api/file/${this.$route.params.id}/details`)
      if (!res.ok) return
      this.dataSet = res.result
    },

    async fetchDatum() {
      if (!this.dataSet) return
      const res = await this.ApiGet(`/api/file/${this.$route.params.id}/data`)
      if (!res.ok) return
      this.datum = res.result
    }
  }
}
</script>

<style lang="stylus">
  .details-view
    .two-column-container
      display flex
      justify-content space-between
      width 90%
      position relative
      margin 0 auto
      .info-column
        width 30%
        .info-message
          font-size 1.4rem
        .description
          font-size 1.2rem
      .graph-column
        width 70%
</style>


