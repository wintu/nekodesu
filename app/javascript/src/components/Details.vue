<template>
  <div class="details-view">
    <section class="concept" v-if="dataSet">
      <h1>{{dataSet.title}}</h1>
    </section>

    <div class="two-column-container">
      <div class="info-column" v-if="dataSet">
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
          <vs-button color="primary" type="border" icon="arrow_downward" @click="download">CSVダウンロード</vs-button>
        </div>
      </div>
      <div class="graph-column" v-if="datum && datum.display_type === 0">
        <vs-table :data="datum.body">
          <template slot="thead">
            <vs-th v-for="(key, index) in Object.keys(datum.body[0])" :key="index">
              {{key}}
            </vs-th>
          </template>
    
          <template slot-scope="{data}">
            <vs-tr :key="indextr" v-for="(tr, indextr) in data" >
              <vs-td v-for="(item, index) in Object.values(data[indextr])" :data="item" :key="index">
                {{item}}
              </vs-td>
            </vs-tr>
          </template>
        </vs-table>
      </div>

      <div class="graph-column" v-if="datum && datum.display_type === 1">
        <vs-select
          class="login-input"
          v-model="selectLabel"
        >
          <vs-select-item :key="index" :value="item" :text="item" v-for="(item,index) in filterHeaders" />
        </vs-select>
        <bar-chart :chartData="chartData(targetLabelValues, selectLabel, targetData(selectLabel))" :options="{}" />
      </div>

    </div>
  </div>
</template>

<script>
import BarChart from '../libs/BarCharts'

export default {
  name: 'Details',
  props: ['common'],
  components: { BarChart },

  data() {
    return {
      dataSet: undefined,
      datum: undefined,
      selectLabel: '',
    }
  },

  async created() {
    await this.fetchDataSet()
    await this.fetchDatum()
  },

  computed: {
    targetLabelValues() {
      if (!this.datum) return
      const idx = Object.keys(this.datum.body[0]).indexOf(this.datum.target_label)
      return this.datum.body.slice(1).map(data => Object.values(data)[idx])
    },

    filterHeaders() {
      if (!this.datum) return
      return Object.keys(this.datum.body[0]).filter(head => head !== this.datum.target_label)
    }
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
      this.selectLabel = this.filterHeaders[0]
    },

    targetData(selectLabel) {
      if (!this.datum) return
      const idx = Object.keys(this.datum.body[0]).indexOf(selectLabel)
      return this.datum.body.slice(1).map(data => ~~Object.values(data)[idx].split(',').join(''))
    },

    chartData(targetLabelValues, selectLabel, targetData) {
      return {
        labels: targetLabelValues,
        datasets: [
          {
            label: selectLabel,
            backgroundColor: '#f87979',
            data: targetData
          }
        ]
      }
    },

    download() {
      window.location = `/api/file/${this.dataSet.id}/download`
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
          word-break break-all
      .graph-column
        width 70%
</style>


