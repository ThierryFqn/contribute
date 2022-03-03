import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["participants", "down", "up", "accepted", "pending"];

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

  displayAccepted() {
    this.acceptedTarget.classList.remove("d-none")
    this.pendingTarget.classList.add('d-none')
  }

  displayPending() {
    this.acceptedTarget.classList.add("d-none")
    this.pendingTarget.classList.remove('d-none')
  }


}
