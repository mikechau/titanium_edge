class Dashing.Pie extends Dashing.Widget

  ready: ->

  createChart: (series, color) ->
    container = $(@node).find('.pie-container')
    if $(container)[0]
      @chart = new Highcharts.Chart(
        
        chart:
          renderTo: $(container)[0]
          backgroundColor: null
          marginTop: 0

        series: series

        title:
          text: ''

        tooltip:
          pointFormat: '{series.name} Total: <b>{point.y}</b>'

        plotOptions:
          pie:
            animation:
              duration: 1700
              easing: 'linear'
            borderWidth: 0
          series:
            dataLabels:
              enabled: true
              distance: -27
              color: 'white'
              style:
                fontSize: '15 px'
              formatter: ->
                "<b>" + @point.name + ": <br/><br/>" + Math.round(@percentage) + " %</b>"

        navigation:
          buttonOptions:
            verticalAlign: 'top'
            y: -15
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

        series: series
      )

  onData: (data) ->
    @createChart(data.series, data.color)