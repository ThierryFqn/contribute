// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
// import "bootstrap"

import { initFlatpickr } from "../plugins/flatpickr";

import { initSweetalert } from '../plugins/init_sweetalert';

document.addEventListener('turbolinks:load', () => {
  initFlatpickr();
  initSweetalert('#sweet-alert-demo', {
    title: "Chaque potentiel volontaire a bien reçu un email !",
    text: "N'hésitez pas à les relancer quelques jours avant l'événement 😊 ",
    icon: "success"
  }, (value) => {
    console.log(value);
  });
})
