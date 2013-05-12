class Dashing.Stacker extends Dashing.Widget

  ready: ->

  createChart: (series, color) ->
    container = $(@node).find('.hc-container')
    if $(container)[0]
      @chart = new Highcharts.Chart(

        chart:
          renderTo: $(container)[0]
          type: "column"
          backgroundColor: null
          marginTop: 0
          marginRight: 0
          marginLeft: 0

        title:
          text: ''

        legend:
          enabled: false
          borderColor: 'white'
          borderWidth: 2

        xAxis:
          lineWidth: 0
          minorGridLineWidth: 0
          lineColor: 'transparent'
          labels:
            enabled: false
          minorTickLength: 0
          tickLength: 0

        yAxis:
          gridLineWidth: 0

        tooltip: 
          formatter: ->
            "<b>" + @series.name + ":</b> " + @y + "<br/>" + "<b>Total: </b>" + @point.stackTotal
   
        plotOptions:
          column:
            stacking: 'normal'
            cursor: "pointer"
            animation:
              duration: 1500
              easing: 'easeOutBounce'
            showInLegend: false
            dataLabels:
              enabled: true
              format: '#{series.name} @ {y}'
              color: "white"
              style:
                fontSize: '20px'
              connectorColor: "#000000"
            borderWidth: 0

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