import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { chatroomId: Number, userId: Number }
  static targets = [ "messages", "form" ]

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
    this.messagesTarget.insertAdjacentHTML("beforeend", data.html)
    const messages = this.messagesTarget.querySelectorAll('.message')
    const lastMessage = messages[messages.length - 1]

    console.log(this.userIdValue)
    console.log(data.user_id)

    if (this.userIdValue === data.user_id) {
      lastMessage.classList.add('message-end')
    } else {
      lastMessage.classList.remove('message-end')
      lastMessage.classList.add('message-start')
    }

    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.formTarget.reset()
    this._scrollToEndOfModal()
  }

  _scrollToEndOfModal() {
    const height = this.modalBodyTarget.offsetHeight
    this.modalBodyTarget.scrollTo(0, height)
  }
}
