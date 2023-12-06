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
              'rgb(255, 117, 23)'
            ],

          },
          {
            label: 'Total Player Stats',
            data: Object.values(totalStats),
            backgroundColor: [
              'rgb(246, 244, 244)'
            ],

          },
        ],
      },
      options:{
        plugins: {
          legend:{
            labels: {
              color: 'rgb(246, 244, 244)',
              font: {
                size: 14,
              },
            },
          },
        },
      },
    })
  }

  polarChart(data) {
    const labels = ['Points', 'Assist', 'Rebound', 'Block', 'Turnover']
    const radarTotal = data.radar_total_stats
    new Chart(this.chartPolarTarget, {
      type: 'radar',
      data: {
        labels: labels,
        datasets: [
          {
            fill: true,
            label: 'My Player',
            data: Object.values(radarTotal),
            backgroundColor: 'rgb(255, 117, 23)',
            borderColor: 'rgb(255, 117, 23)',
            pointBackgroundColor: 'rgb(255, 117, 23)',
            pointBorderColor: 'rgb(246,244,244)',
            pointHoverBackgroundColor: 'rgb(246,244,244)',
            pointHoverBorderColor: 'rgb(255, 117, 23)',
          },
        ],
      },
      options:{
        plugins: {
          legend:{
            labels: {
              color: 'rgb(246, 244, 244)',
              font: {
                size: 14,
              },
            },
          },
        },
      },
    })
  }

}
