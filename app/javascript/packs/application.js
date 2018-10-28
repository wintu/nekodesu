import Vue from 'vue'
import Router from 'vue-router'
import Axios from 'axios'
import Vuesax from 'vuesax'
import App from '../src/App.vue'

Vue.use(Router)
Vue.use(Vuesax)

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
        const metaTags = document.getElementsByTagName('meta')
        const token = Array.from(metaTags).find(meta => meta.name === 'csrf-token')
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
  { path: '/', component: require('../src/components/Top.vue').default },
  { path: '/login', component: require('../src/components/auth/Login.vue').default },
  { path: '/register', component: require('../src/components/auth/Register.vue').default },
  { path: '/search', component: require('../src/components/Search.vue').default },
  { path: '/details/:id', component: require('../src/components/Details.vue').default },
  { path: '/upload', component: require('../src/components/Upload.vue').default, meta: { requiresAuth: true } }
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
