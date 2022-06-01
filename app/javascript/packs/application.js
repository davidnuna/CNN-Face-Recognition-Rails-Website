/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

require("jquery")
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
window.$ = jQuery;

require("src/select_user")
require("src/image_method")
require("src/camera_screenshots")
require("src/add_question")

import "bootstrap"

$(function () {
  console.log('Hello World from Webpacker');
});
