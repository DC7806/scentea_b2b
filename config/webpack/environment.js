const { environment } = require('@rails/webpacker')

environment.loaders.delete('nodeModules')

module.exports = environment

environment.loaders.append('expose', {
  test: require.resolve('jquery'),
  loader: 'expose-loader',
  options: {
    exposes: ['$', 'jQuery']
  }
})
