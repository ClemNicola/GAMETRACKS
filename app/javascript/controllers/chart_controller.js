import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chart"
export default class extends Controller {

  static value = {
    id: String,
  }


  connect() {
    const chart = Chartkick.charts[this.idValue]

    // const controllers = Object.values(Chartjs).filter(
    //   (chart) => chart.id !== undefined
    // )
    // Chart.register(...controllers)

  }
}
