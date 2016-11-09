class Field < ActiveRecord::Base
  class CurrentWeather < Show
    representer Representer::ShowWithWeather

    def setup_model!(params)
      location = [model.center_lat, model.center_lon]
      model.weather_datapoints = Weather::Service.new.current_weather(location)
    end
  end

  class FutureWeather < Show
    representer Representer::ShowWithWeather

    def setup_model!(params)
      location = [model.center_lat, model.center_lon]
      model.weather_datapoints = Weather::Service.new.future_weather(location)
    end
  end
end
