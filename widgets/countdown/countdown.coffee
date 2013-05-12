class Dashing.Countdown extends Dashing.Widget

  ready: ->
    setInterval(@startCountdown, 500)

  startCountdown: =>
    current = new Date()
    if current.toLocaleTimeString() > "8:30:00 AM"
      count_to_close = true
    else
      count_to_close = false
    current_timestamp = Math.round(new Date().getTime()/1000)
    end_timestamp = Math.round( Date.parse($(@node).find(".more-info").html())/1000 )
    seconds_until_end = end_timestamp - current_timestamp
    if seconds_until_end < 0
      @set('timeleft', "TIME UP!")
      count_to_close = true
      for i in [0..15] by 1
        $(@node).fadeTo('fast', 0).fadeTo('fast', 1.0)
      if i > 15 && count_to_close == true
        today = new Date()
        tomorrow = new Date()
        tomorrow.setDate(today.getDate()+1)
        tomorrow.setHours(8)
        tomorrow.setMinutes(30)
        tomorrow.setSeconds(0)
        count_to_close = false
        return @set('title', "Opening In") && @set('end', tomorrow.toLocaleString() )
      else
        today = new Date()
        today.setHours(15)
        today.setMinutes(0)
        today.setSeconds(0)
        count_to_close = true
        return @set('title', "Closing In") && @set('end', today.toLocaleString() )
    else
      d = Math.floor(seconds_until_end/86400)
      h = Math.floor((seconds_until_end-(d*86400))/3600)
      m = Math.floor((seconds_until_end-(d*86400)-(h*3600))/60)
      s = seconds_until_end-(d*86400)-(h*3600)-(m*60)
      if d >0
        dayname = 'day'
        if d > 1
          dayname = 'days'
        @set('timeleft', d + " "+dayname+" " + @formatTime(h) + ":" + @formatTime(m) + ":" + @formatTime(s))
      else
        @set('timeleft', @formatTime(h) + ":" + @formatTime(m) + ":" + @formatTime(s))


  formatTime: (i) ->
    if i < 10 then "0" + i else i