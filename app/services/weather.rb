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
end
