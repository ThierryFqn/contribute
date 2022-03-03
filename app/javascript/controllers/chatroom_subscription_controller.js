import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = [ "messages", "form", "modalBody" ]

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.received(data) }
      )
  }

  received(data) {
    this._insertMessageScrollDownAndResetForm(data)
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  _insertMessageScrollDownAndResetForm(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.formTarget.reset()
    this._scrollToEndOfModal()
  }

  _scrollToEndOfModal() {
    const height = this.modalBodyTarget.offsetHeight
    this.modalBodyTarget.scrollTo(0, height)
  }
}
