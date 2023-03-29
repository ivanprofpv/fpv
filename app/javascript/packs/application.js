/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "channels"

require("trix")
require("@rails/actiontext")
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("jquery")
require("comments/edit")
require("components/add_component")
require("components/edit")

require("@popperjs/core")

import "bootstrap"
import "trix"
import "@rails/actiontext"



// Import the specific modules you may need (Modal, Alert, etc)
// import { Tooltip, Popover } from "bootstrap"

// // The stylesheet location we created earlier
// require("../stylesheets/application.scss")

// If you're using Turbolinks. Otherwise simply use: jQuery(function () {
// document.addEventListener("turbolinks:load", () => {
//     // Both of these are from the Bootstrap 5 docs
//     var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
//     var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
//         return new Tooltip(tooltipTriggerEl)
//     })

//     var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
//     var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
//         return new Popover(popoverTriggerEl)
//     })
// })
