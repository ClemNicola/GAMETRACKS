import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="titulaire"
export default class extends Controller {
  connect() {

  }

  newTitulaire(event) {
    console.log(event.currentTarget.children[0].id)
    event.currentTarget.classList.toggle("titu")
    id = event.currentTarget.children[0].id
    

  }
}
