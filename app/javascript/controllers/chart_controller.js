import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chart"
export default class extends Controller {

  static targets = [
    'chart'
  ]

  connect() {
    // const controllers = Object.values(Chartjs).filter(
    //   (chart) => chart.id !== undefined
    // )
    // Chart.register(...controllers)
    const labels = ['Red', 'Blue', 'Yellow']
    const data = [300, 50, 100]

    new Chart(this.chartTarget, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: 'My First Dataset',
          data: data,
          backgroundColor: [
          'rgb(255, 99, 132)',
          'rgb(54, 162, 235)',
          'rgb(255, 205, 86)'
          ],
          hoverOffset: 4
        }]
      }
    })
  }
}
