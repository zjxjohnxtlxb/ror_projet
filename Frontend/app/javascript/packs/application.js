/*
 * @Date: 2021-07-29 17:20:58
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-18 16:22:35
 * @FilePath: /Frontend/app/javascript/packs/application.js
 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import "channels"
import 'bootstrap';
require('packs/social-share-button.js.erb')

Rails.start()
Turbolinks.start()

