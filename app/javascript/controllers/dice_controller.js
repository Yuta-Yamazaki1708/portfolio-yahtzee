import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dice"
export default class extends Controller {
  static targets = [ "dice" ]

  display_image() {
    const element = this.diceTarget
    const num = element.innerHTML
    console.log("test", num)
  }
}
