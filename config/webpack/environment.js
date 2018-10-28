const { environment } = require('@rails/webpacker')
const vue = require('./loaders/vue')

environment.loaders.append('vue', vue)
environment.loaders.append('stylus', {
  test: /\.styl(us)?$/,
  use: ['style-loader', 'css-loader', 'stylus-loader']
})

module.exports = environment
