import { Bar } from 'vue-chartjs'

export default {
  extends: Bar,
  props: ['targetLabelValues', 'targetLabel', 'targetData'],
  mounted () {
    // Overwriting base render method with actual data.
    this.renderChart({
      labels: this.targetLabelValues,
      datasets: [
        {
          label: this.targetLabel,
          backgroundColor: '#f87979',
          data: this.targetData
        }
      ]
    })
  }
}
