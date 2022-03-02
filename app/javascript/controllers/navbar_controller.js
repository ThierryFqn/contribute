import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  updateNavbar() {
    if (window.scrollY >= 0.2* window.innerHeight) {
      this.element.classList.add("navbar-lewagon-white")
    } else {
      this.element.classList.remove("navbar-lewagon-white")
    }
  };
}
