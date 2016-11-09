require './owm.rb'
class Weather
  attr_accessor :temperature
  attr_accessor :pressure
  attr_accessor :downfall
  attr_accessor :humidity

  def initialize(params)
    @temperature = params[:temperature]
    @humidity = params[:humidity]
    @pressure = params[:pressure]
    @downfall = params[:downfall]
  end

  class Service
    def initialize
      @provider = Owm.new(Rails.application.secrets.open_weather_map_key)
    end

    def current_weather(location)
      [@provider.current(*location)]
    end
    
    def future_weather(location)
      @provider.forecast_5(*location)
    end
  end
end

