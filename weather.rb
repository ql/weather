require './owm.rb'

class WeatherService
  def initialize(key)
    @provider = Owm.new(key)
  end

  def current(location)
    @provider.current(*location)
  end
  
  def next_3(location)
    @provider.forecast_5(*location)
  end
end
