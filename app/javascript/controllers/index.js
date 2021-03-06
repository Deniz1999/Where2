// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

const updateScroll = () => {
  const element = document.querySelector(".message-box");
  element.scrollTop = element.scrollHeight;
  console.log("hello");
}

if (document.querySelector(".message-box")) {
  updateScroll();
}

const element = document.querySelector(".send-button")

if (document.querySelector(".send-button")){
  element.addEventListener('click', (event) => {
  setInterval(updateScroll, 500);
});
}
