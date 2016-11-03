require './owm.rb'

class Weather
  class Service
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
end
