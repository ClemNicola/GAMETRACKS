import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checked-player"
export default class extends Controller {
  static targets = [
    'button',
    'checkboxesContainer'
  ]

  connect() {
  }

  select(event) {
    const playerImg = event.currentTarget.querySelector('.imgimgimg')
    playerImg.classList.add('selected')
  }

  countPlayers() {
    const checkedCheckboxes = this.checkboxesContainerTarget.querySelectorAll('input[type=checkbox]:checked').length
    if (checkedCheckboxes === 5) {
      this.buttonTarget.hidden = false
    } else {
      this.buttonTarget.hidden = true
    }
  }
}
