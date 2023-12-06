import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-stats"
export default class extends Controller {
  connect() {
    console.log("coucou");
  }

  action(event) {
    event.preventDefault();
    const target = event.currentTarget;
    const type = target.dataset.type

    const gameId = document.getElementById("player_stat_game_id").value
    this.body = {
      game_id: gameId,
      player_stat: {
      }
    }
    this.body.player_stat[type] = 1
    console.log(this.body)

  }

  player(event) {
    const target = event.currentTarget
    const participationId = target.dataset.id
    this.body = {...this.body,
      participation_id: participationId}
    this.ajax(this.body)
  }

  ajax(body) {
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
    const url = "/player_stats"
    fetch(url, {
      method: "POST",
      headers : {
        "X-CSRF-Token": token,
        "Content-Type": "application/json"
      },
      body: JSON.stringify(body)
    })
  }
}
