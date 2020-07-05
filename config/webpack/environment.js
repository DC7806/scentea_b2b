const { environment } = require('@rails/webpacker')

module.exports = environment

environment.loaders.append('expose', {
  test: require.resolve('jquery'),
  loader: 'expose-loader',
  options: {
    exposes: ['$', 'jQuery']
  }
})
