import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dice"
export default class extends Controller {
  static targets = [ "dice0", "dice1", "dice2", "dice3", "dice4" ]

  connect() {
  }

  roll_dice() {
    fetch('/get_roll_count')
    .then(response => response.json())
    .then(data => {
      const rollCount = data.roll_count
      const maxRollDices = data.max_roll_dices
      if (rollCount <= maxRollDices) {
        for (let i = 0; i < 5; i++) {
          const currentDice = this[`dice${i}Target`];
          currentDice.classList.add("rolling");
          setTimeout(() => {
            currentDice.classList.remove("rolling");
          }, 1000);
        }
      }
    })
    .catch(error => console.error('Error:', error));
  }
}
