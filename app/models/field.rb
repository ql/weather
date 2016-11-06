class Field < ActiveRecord::Base
  belongs_to :user

  attr_accessor :weather_datapoints
end
