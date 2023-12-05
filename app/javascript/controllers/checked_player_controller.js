import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checked-player"
export default class extends Controller {
  static targets = [
    'button',
    'checkboxesContainer',
    'playersContainer',
    'buttonNext',
    'count'
  ]

  connect() {
    console.log('yo');
  }

  select(event) {
    event.preventDefault()
    const playerImg = event.currentTarget.querySelector('.imgimgimg')
    playerImg.classList.toggle('selected')
    const checkbox = event.currentTarget.querySelector('input[type=checkbox]')
    checkbox.checked = !checkbox.checked
    this.countPlayers()
  }

  countPlayers() {
    const checkedCheckboxes = this.checkboxesContainerTarget.querySelectorAll('input[type=checkbox]:checked').length
    if (checkedCheckboxes === 5) {
      this.buttonTarget.hidden = false
    } else {
      this.buttonTarget.hidden = true
    }
  }

  selectCard(event) {
    event.preventDefault()
    const card = event.currentTarget
    const checkbox = card.querySelector('input[type=checkbox]')
    const icon = card.querySelector('.fa-regular')
    icon.hidden = !icon.hidden
    checkbox.checked = !checkbox.checked
    card.classList.toggle('checked')
    this.countPlayersCard()

  }


  countPlayersCard() {
    const checkedCheckboxes = this.playersContainerTarget.querySelectorAll('input[type=checkbox]:checked').length
    this.buttonNextTarget.hidden = checkedCheckboxes < 5;
    this.countTarget.innerText = `${checkedCheckboxes}/10`
  }
}
