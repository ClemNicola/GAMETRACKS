import { Controller } from "stimulus";
import Chartkick from "chartkick";
import { columnChart } from "chartkick";

export default class extends Controller {
  connect() {
    this.loadStats();
  }

  loadStats() {
    const gameId = this.data.get("gameId");
    fetch(`/games/${gameId}/stats`)
      .then((response) => response.json())
      .then((data) => {
        const chartData = {
          "Home Team Stats": data.home_stats,
          "Total Team Stats": data.total_team_stats,
        };

        const chartOptions = {
          series: {
            0: { type: "column" },
            1: { type: "column" },
          },
        };

        const chartElement = document.getElementById("chart");
        if (chartElement) {
          new Chartkick.ColumnChart("chart", chartData);
        }

      })
      .catch((error) => {
        console.error("Error fetching stats data:", error);
      });
  }
}
