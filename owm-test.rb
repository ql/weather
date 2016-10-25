require './weather.rb'
loc = [55.754734,37.602540]
weather = WeatherService.new '14556c4b2d8c3590bad26523ddbf353f'
p weather.current(loc)
p weather.next_3(loc)
