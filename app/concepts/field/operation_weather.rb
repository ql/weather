class Field < ActiveRecord::Base
  class CurrentWeather < Show
    representer Representer::ShowWithWeather

    def setup_model!
      location = [model.center_lat, model.center_lon]
      model.weather_datapoints = WeatherService.new.current_weather(location)
    end
  end

  class FutureWeather < Show
    def setup_model!
      location = [model.center_lat, model.center_lon]
      model.weather_datapoints = WeatherService.new.future_weather(location)
    end
  end
end
