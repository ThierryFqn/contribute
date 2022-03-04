// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import flatpickr from "flatpickr";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "distance" ]

  connect() {
    // flatpickr(".datepicker", {})
    this.distanceTarget.innerText = 30
  }

  change(evt) {
    this.distanceTarget.innerText = evt.target.value
  }
}
