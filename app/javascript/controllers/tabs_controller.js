import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["accept", "pend", "acceptedCount", "pendingCount"]

  connect() {
    console.log("Hello")
  }

  validate(e) {
    e.preventDefault();
    e.stopPropagation();

    fetch(`/participations/${e.target.dataset.participationId}/accepted`, {
      method: "PATCH",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    })
      .then(response => response.json())
      .then((data) => {
        if (data.pending_count === 0) {
          document.querySelector('.participants-pending').style.display = 'none';
        } else {
          document.querySelector('.participants-pending').style.display = 'block';
        }

        document.querySelector(`#participation_${data.participation_id}`).remove();
        this.pendingCountTarget.innerText = data.pending_count
        this.acceptedCountTarget.innerText = data.accepted_count
        this.acceptTarget.insertAdjacentHTML("beforeend", data.html)
      })
  }
}
