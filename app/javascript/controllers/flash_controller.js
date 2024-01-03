import { Controller } from "@hotwired/stimulus"
import "bootstrap"
// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    const flashMesseage = new bootstrap.Toast(this.element)
    flashMesseage.show()
  }
}
