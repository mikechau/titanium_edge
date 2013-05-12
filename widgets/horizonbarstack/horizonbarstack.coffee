class Dashing.Horizonbarstack extends Dashing.Widget

  ready: ->

    Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, (color) ->
      Highcharts.Color(color).setOpacity(0.82).get "rgba"
    )

  createChart: (series, categories, color) ->
    container = $(@node).find('.horizon-container')
    if $(container)[0]
      @chart = new Highcharts.Chart(

        chart:
          renderTo: $(container)[0]
          type: "bar"
          backgroundColor: null
          marginTop: 0
          marginRight: 15

        title:
          text: ''

        legend:
          enabled: false
          reversed: true
          borderColor: 'white'
          borderWidth: 2

        xAxis:
          categories: categories
          labels:
            enabled: false
          minorGridLineWidth: 0
          minorTickLength: 0
          tickLength: 0

        yAxis:
          gridLineColor: 'gray'
          stackLabels:
            style:
              color: 'white'
            enabled: false
            verticalAlign: 'middle'
            align: 'left'
            #formatter: ->
            #  categories[@x]

          title:
            text: "Total Number of Transactions"

        tooltip: 
          formatter: ->
            "<b>" + @series.name + "<br/>" + "<b> Transactions:</b> " + @y + "<br/>"
   
        plotOptions:
          series:
            stacking: 'normal'
            borderWidth: 0
            pointPadding: 0
            groupPadding: 0
          bar:
            colorByPoint: true
            cursor: "pointer"
            animation:
              duration: 2000
              easing: 'easeOutBounce'
            showInLegend: false
            dataLabels:
              enabled: true
              format: '{x}' + ': {y}'
              color: "white"
              align: 'left'
              verticalAlign: 'middle'
              style:
                fontSize: '17 px'
              connectorColor: "#000000"


        navigation:
          buttonOptions:
            verticalAlign: 'top'
            y: -7
            x: -9
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
    @createChart(data.series, data.categories, data.color)