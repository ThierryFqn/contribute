import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["participants", "down", "up"];

  displayDiv() {
    this.participantsTarget.classList.remove('d-none')
    this.downTarget.classList.add('d-none')
    this.upTarget.classList.remove('d-none')
  }


  hideDiv() {
    this.participantsTarget.classList.add("d-none")
    this.downTarget.classList.remove('d-none')
    this.upTarget.classList.add('d-none')
  }
}
