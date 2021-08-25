/*
 * @Date: 2021-07-29 17:21:04
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-21 21:43:17
 * @FilePath: /Frontend/config/webpack/environment.js
 */
const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')
const coffee =  require('./loaders/coffee')

environment.loaders.prepend('coffee', coffee)
environment.loaders.prepend('erb', erb)

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    '$': 'jquery',
    'jQuery': 'jquery'
  })
)

const aliasConfig = {
    'jquery': 'jquery/src/jquery',
    'jquery-ui': 'jquery-ui-dist/jquery-ui'
};

environment.config.set('resolve.alias', aliasConfig);

module.exports = environment
