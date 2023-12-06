import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="player-charts"
export default class extends Controller {

  static targets = [
    'chartBar',
    'chartPolar',
  ]

  static values = {
    playerId: Number
  }

  connect() {
    console.log(this.playerIdValue);
    this.loadStats()
    this.polarStats()
  }

  loadStats() {
    fetch(`/players/${this.playerIdValue}/player_data`)
      .then((response) => response.json())
      .then((data) => {
        this.createChart(data)
      })
      .catch((error) => {
        console.error("Error fetching stats data:", error);
      });
  }

  polarStats() {
    fetch(`/players/${this.playerIdValue}/radar_player_data`)
      .then((response) => response.json())
      .then((data) => {
        this.polarChart(data)
      })
      .catch((error) => {
        console.error("Error fetching stats data:", error);
      });
  }

  createChart(data) {
    const labels = ['Minutes','Points', 'Assist', 'Rebound', 'Off Rebound', 'Def Rebound', 'Block', 'Turnover', 'Eval Player']
    const playerStats = data.player_stat_for_game
    const totalStats = data.mean_player_stats

    new Chart(this.chartBarTarget, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [
          {
            label: 'My Game Stat',
            data: Object.values(playerStats),
            backgroundColor: [
            'rgb(255, 99, 132)',
            'rgb(54, 162, 235)',
            'rgb(54, 162, 235)',
            'rgb(54, 162, 235)',
            'rgb(255, 205, 86)'
            ],
            hoverOffset: 4
          },
          {
            label: 'Total Player Stats',
            data: Object.values(totalStats),
            backgroundColor: [
            'rgb(54, 162, 235)',
            'rgb(255, 99, 132)',
            'rgb(255, 99, 132)',
            'rgb(255, 99, 132)',
            'rgb(255, 205, 86)'
            ],
            hoverOffset: 4
          }
        ]
      }
    })
  }

  polarChart(data) {
    const labels = ['Points', 'Assist', 'Rebound', 'Off Rebound', 'Def Rebound', 'Block', 'Turnover', 'Eval Player']
    const radarStats = data.radar_player_stats
    new Chart(this.chartPolarTarget, {
      type: 'radar',
      data: {
        labels: labels,
        datasets: [
          {
            fill: true,
            label: 'My Player',
            data: Object.values(radarStats),
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgb(255, 99, 132)',
            pointBackgroundColor: 'rgb(255, 99, 132)',
            pointBorderColor: 'rgb(255, 99, 132)',
            pointHoverBackgroundColor: '#0000000',
            pointHoverBorderColor: 'rgb(255, 99, 132)',
            hoverOffset: 4
          }
        ]
      }
    })
  }

}
