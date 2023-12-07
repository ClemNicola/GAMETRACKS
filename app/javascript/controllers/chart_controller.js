import { Controller } from "@hotwired/stimulus";
// import Chartkick from "chartkick";
// import { columnChart } from "chartkick";

export default class extends Controller {

  static targets = [
    'chartContainer',
    'chartLine',
    'chartLineBis'
  ]

  static values = {
    gameId: Number
  }

  connect() {
    console.log(this.gameIdValue);
    this.loadStats()
    this.loadQuarters()
    this.totalQuarters();
  }

  loadStats() {
    fetch(`/games/${this.gameIdValue}/stats.json`)
      .then((response) => response.json())
      .then((data) => {
        this.createChart(data)
      })
      .catch((error) => {
        console.error("Error fetching stats data:", error);
      });
  }

  loadQuarters(){
    fetch(`/games/${this.gameIdValue}/quarter_data`)
    .then((response) => response.json())
    .then((data) => {
      this.quarterChart(data)
    })
    .catch((error) => {
      console.error("Error fetching stats data:", error);
    });
  }

  totalQuarters(){
    fetch(`/games/${this.gameIdValue}/total_quarter_data`)
    .then((response) => response.json())
    .then((data) => {
      this.totalQuarterChart(data)
    })
    .catch((error) => {
      console.error("Error fetching stats data:", error);
    });
  }

  createChart(data) {
    const labels = ['Points', 'Assist', 'Off Rebound', 'Def Rebound', 'Turnover']
    const gameStats = data.home_stats
    const totalStats = data.total_team_stats

    new Chart(this.chartContainerTarget, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [
          {
            label: 'Game Team Stats',
            data: Object.values(gameStats),
            backgroundColor: [
            'rgb(255, 117, 23)',
            ],
          },
          {
            label: 'Total Team Stats',
            data: Object.values(totalStats),
            backgroundColor: [
            'rgb(246,244,244)',
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

  quarterChart(data) {
    const labels = ["Q1","Q2", "Q3", "Q4"]
    const quarterHome = data.score_per_quarter_team
    const quarterOpponent = data.score_per_quarter_opponent

    new Chart (this.chartLineTarget, {
      type: 'line',
      data: {
        labels: labels,
        datasets: [
          {
            label: 'Team point per quarter',
            data: Object.values(quarterHome),
            fill: false,
            borderColor: 'rgb(255, 117, 23)',
          },
          {
            label: 'Opponent point per quarter',
            data: Object.values(quarterOpponent),
            fill: false,
            borderColor: 'rgb(246,244,244)',
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

  totalQuarterChart(data) {
    const labels = ["Q1","Q2", "Q3", "Q4"]
    const TotalQuarterHome = data.total_score_per_quarter_team
    const TotalQuarterOpponent = data.total_score_per_quarter_opponent

    new Chart (this.chartLineBisTarget, {
      type: 'line',
      data: {
        labels: labels,
        datasets: [
          {
            label: 'Total Team points per quarter',
            data: Object.values(TotalQuarterHome),
            fill: false,
            borderColor: 'rgb(255, 117, 23)',
          },
          {
            label: 'Total Opponent points per quarter',
            data: Object.values(TotalQuarterOpponent),
            fill: false,
            borderColor: 'rgb(246,244,244)',
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

}
