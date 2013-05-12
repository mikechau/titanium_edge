require 'httparty'
require 'json'

last_transaction = 0

SCHEDULER.every '5s', allow_overlapping: false do

  ### TOP UNDERLYING
  list2_array = []
  list2 = { "ARM"=>rand(100), "AMZN"=>rand(100), "INTL"=>rand(100), "PT"=>rand(100), "GLW"=>rand(100), "GLD"=>rand(100), "AUY"=>rand(100), "X"=>rand(100), "SFL"=>rand(100), "AKRX"=>rand(100) }

  list2 = list2.sort_by &:last
  list2.reverse!

  list2[0..4].each do |list|
    input_hash = Hash.new
    input_hash["name"] = list[0]
    input_hash["data"] = [list[1]]
    input_hash["pointWidth"] = 500
    list2_array << input_hash
  end

  send_event('top_underlying', { series: list2_array, color: '#d35400' })

  ### TOP EXCHANGES
  ex_keys = ["AMEX", "NYSE", "NASDAQ", "TMX", "SEHK", "LSE", "SGX"]
  ex_data = (1..999).to_a.sample 7

  sorted_exchanges = ex_keys.zip(ex_data).sort_by &:last
  ex_cats = sorted_exchanges.map { |ex| ex[0] }
  ex_data = sorted_exchanges.map { |ex| ex[1] }

  send_event('top_exchanges', { series: [{ data: ex_data }], categories: ex_cats, color: '#efad1b' })

  ### PPL WHO LIKE PIE
  pie_series = [{ type: 'pie', name: 'Type', data: [["LOVE", rand(1000)], ["LIKE", rand(1000)], ["HATE", rand(1000)], ["CAKE?", rand(1000)]] }]

  send_event('pie_ppl', { series: pie_series, color: '#f39c12' })


  ### TOP 10 INSTRUMENTS

  top_instruments = [["BANJO", rand(1000)], ["GUITAR", rand(1000)], ["DRUMS", rand(1000)], ["FLUTE", rand(1000)], ["PIANO", rand(1000)], ["VIOLA", rand(1000)], ["BEATBOX", rand(1000)], ["UKULELE", rand(1000)], ["CLAPPING", rand(1000)], ["ABLETON", rand(1000)]]
  top_instruments = top_instruments.sort_by{|k|k[1]}
  top_instruments.reverse!

  ti_cats = top_instruments.map { |list| list[0] }
  ti_data = top_instruments.map { |list| list[1] }

  send_event('top_instruments', { series: [{ name: 'Instruments', data: ti_data }], categories: ti_cats, color: '#2c3e50' })

  ### RECENT TRANSACTIONS
  rt_labels = ["BOUGHT APPLES FOR", "BOUGHT BREAD FOR", "SOLD A CAR FOR", "SOLD WATER FOR"].shuffle
  rt_values = ["$59.99", "$9,001.00", "$78.32", "$999.99"].shuffle
  rt_send = []

  (0..3).each do |i|
    rt_hash = {}
    rt_hash["label"] = rt_labels[i]
    rt_hash["value"] = rt_values[i]
    rt_send << rt_hash
  end 
  
  send_event('recent_trades_list', { items: rt_send })

  ### TRANSACTIONS EXECUTED

  current_transaction = rand(9001)
  send_event('total_transactions', { current: current_transaction, last: last_transaction })
  last_transaction = current_transaction
end