import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["description"]

  revealContent() {
    this.descriptionTarget.classList.remove("d-none")
  }

  hideContent() {
    this.descriptionTarget.classList.add("d-none")
  }
}
