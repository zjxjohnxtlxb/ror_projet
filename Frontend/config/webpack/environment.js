/*
 * @Date: 2021-07-29 17:21:04
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-07-30 14:28:14
 * @FilePath: /Frontend/config/webpack/environment.js
 */
const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')
const coffee =  require('./loaders/coffee')

environment.loaders.prepend('coffee', coffee)
environment.loaders.prepend('erb', erb)
module.exports = environment
