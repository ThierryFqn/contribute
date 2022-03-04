import { Controller } from "@hotwired/stimulus"
import places from "places.js";

export default class extends Controller {
  static targets = ["place"]

  connect() {
    places({container: document.querySelector('#search_address')})
  }
}
