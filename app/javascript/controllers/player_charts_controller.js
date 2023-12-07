import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="player-charts"
export default class extends Controller {

  static targets = [
    'chartBar',
    'chartRadar',
  ]

  static values = {
    playerId: Number
  }

  connect() {
    console.log(this.playerIdValue);
    this.loadStats()
    this.radarStats()
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

  radarStats() {
    fetch(`/players/${this.playerIdValue}/radar_player_data`)
      .then((response) => response.json())
      .then((data) => {
        this.radarChart(data)
      })
      .catch((error) => {
        console.error("Error fetching stats data:", error);
      });
  }

  createChart(data) {
    const labels = ['Minutes','Points', 'Assist', 'Rebound', 'Off Rebound', 'Def Rebound', 'Block', 'Turnover', 'Eval Player']
    const playerStats = data.player_stat_for_game
    const avgStats = data.avg_player_stats

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
            label: 'Average Player Stats',
            data: Object.values(avgStats),
            backgroundColor: [
              'rgb(246, 244, 244)'
            ],

          },
        ],
      },
      options:{
        scales: {
          x: {
            ticks:{
              color:'rgb(246,244,244)',
            },
          },
          y:{
            ticks:{
              color: 'rgb(246,244,244)',
            },
          },
        },
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

  radarChart(data) {
    const labels = ['Points', 'Assist', 'Rebound', 'Block', 'Turnover']
    const radarTotal = data.radar_total_stats
    new Chart(this.chartRadarTarget, {
      type: 'radar',
      data: {
        labels: labels,
        datasets: [{
            fill: true,
            label: 'My Player',
            data: Object.values(radarTotal),
            backgroundColor: 'rgb(255, 117, 23, 0.2)',
            borderColor: 'rgb(255, 117, 23,1)',
            pointBackgroundColor: 'rgb(255, 117, 23)',
            pointBorderColor: 'rgb(246,244,244)',
          }],
      },
      options:{
        scales: {
          r: {
            pointLabels: {
              color: 'rgb(246, 244, 244)',
              font: {
                size: 14
              }
            },
            grid: {
              color: 'rgb(70, 70, 70)',
              backgroundColor: 'rgba(188, 188, 188, 0.1)',
            },
            ticks: {
              backdropColor: 'transparent',
              color:'rgb(246, 244, 244)',
            }

          },
        },
        plugins:{
          legend:{
            labels:{
              color: 'rgb(246, 244, 244)',
              font:{
                size: 14,
              }
            }
          },
        },
      },
    })
  }

}
