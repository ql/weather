require 'httparty'
class Owm
  BASE_URL = 'http://api.openweathermap.org/data/2.5/'

  def initialize(key)
    @api_key = key
  end

  def current(lat, lon)
    extract request('weather', lat, lon)
  end

  def forecast_5(lat, lon)
    request('forecast', lat, lon)['list'].map {|h| extract(h) }
  end

  private

  def extract(hash)
    {
      temp: temp2celsius(hash['main']['temp']),
      humidity: hash['main']['humidity'],
      downfall: {
        snow: hash['snow'],
        rain: hash['rain']
      },
      pressure: hash['main']['pressure']
    }
  end

  def temp2celsius(val)
    (val.to_f - 273.15).round(1)
  end

  def request(path, lat, lon)
    JSON.parse(HTTParty.get("#{BASE_URL}#{path}?lat=#{lat}&lon=#{lon}&APPID=#{@api_key}").body)
  end
end
