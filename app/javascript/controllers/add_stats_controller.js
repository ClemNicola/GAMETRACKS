import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-stats"
export default class extends Controller {

  static targets = [
    'opponentScore',
    'myScore',
    'player',
    'action'
  ]

  connect() {
    console.log("coucou");

    this.myScore = 0
    this.opponentScore = 0
    this.score = 0
    this.type = null
  }

  selectPlayer(event) {
    const card = event.currentTarget

    card.classList.toggle('card-test2')
    card.classList.toggle('card-test1')

  }

  action(event) {
    event.preventDefault();
    const target = event.currentTarget;
    const type = target.dataset.type
    this.type = target.dataset.typeAction
    this.score = Number.parseInt(target.dataset.point)
    console.log(this.score);


    // For form
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
    const player = target.dataset.name
    const participationId = target.dataset.id
    const team = target.dataset.team

    if (team === 'home') {
      this.myScore += this.score
    } else if (team === 'opponent') {
      this.opponentScore += this.score
    }

    console.log(team);
    console.log('My score: ', this.myScore);
    console.log('Opponent score: ', this.opponentScore);

    this.myScoreTarget.innerText = this.myScore
    this.opponentScoreTarget.innerText = this.opponentScore

    this.playerTarget.innerText = player
    this.actionTarget.innerText = this.type

    // For form
    this.body = {...this.body,
      participation_id: participationId}
    this.ajax(this.body)
  }

  ajax(body) {
    console.log(body);
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
