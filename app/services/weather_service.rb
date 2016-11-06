require './owm.rb'

class Weather
  class Service
    def initialize
      @provider = Owm.new(Rails.secrets.open_weather_map_key)
    end

    def current_weather(location)
      @provider.current(*location)
    end
    
    def future_weather(location)
      @provider.forecast_5(*location)
    end
  end
end
