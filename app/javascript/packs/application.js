import Vue from 'vue'
import Router from 'vue-router'
import App from './App.vue'

Vue.use(Router)

const routes = [
  { path: '/', component: () => import(/* webpackChunkName: "HelloWorld" */ './components/HelloWorld.vue') }
]

const router = new Router({
  mode: 'history',
  routes
})

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    router,
    render: (h) => h(App),
  })
})