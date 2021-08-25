/*
 * @Date: 2021-08-20 16:42:03
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-23 17:57:03
 * @FilePath: /Frontend/app/javascript/components.js
 */
function importAll(r) {
  r.keys().forEach(r)
}

importAll(require.context("../components", true, /[_\/]component\.js$/))