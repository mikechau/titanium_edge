class Dashing.Highbar extends Dashing.Widget

  createChart: (series, categories, color) ->
    container = $(@node).find('.highchart-container')
    if $(container)[0]
      @chart = new Highcharts.Chart(
        chart:
          renderTo: $(container)[0]
          type: "column"
          backgroundColor: color
          marginTop: 2

        title:
          text: ' '

        xAxis:
          categories: categories

        legend:
          enabled: false

        series: series

        tooltip:
          pointFormat: '<b>{point.y}</b>'

        plotOptions:
          column:
            cursor: 'pointer'
            animation:
              #redraw: true
              duration: 2000
              easing: 'easeOutBounce'
            dataLabels:
              enabled: true
              style:
                fontWeight: 'bold'

        navigation:
          buttonOptions:
            verticalAlign: 'top'
            theme:
              'stroke-width': 1
              stroke: color
              r: 0
              fill: color
              states:
                hover:
                  fill: color
                select:
                  fill: color

      )

  onData: (data) ->
    @createChart(data.series, data.categories, data.color)