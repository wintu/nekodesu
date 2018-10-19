import Vue from 'vue'
import Router from 'vue-router'
import Axios from 'axios'
import App from './App.vue'

Vue.use(Router)

Vue.mixin({
  methods: {
    async ApiGet (endPoint) {
      try {
        const res = await Axios.get(endPoint)
        return res.data
      } catch (e) {
        return e.response ? e.message.data : { error: e.response }
      }
    },

    async ApiPost (endPoint, params) {
      try {
        const token = document.getElementsByTagName('meta').find(meta => meta.name === 'csrf-token')
        params.authenticity_token = token.content
        const res = await Axios.post(endPoint, params)
        return res.data
      } catch (e) {
        return e.response ? e.response.data : { error: e.response }
      }
    }
  }
})

const routes = [
  { path: '/', component: require('./components/HelloWorld.vue').default }
]

const router = new Router({
  mode: 'history',
  routes
})

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    router,
    render: (h) => h(App)
  })
})
