require 'representable/json'

class Field < ActiveRecord::Base
  class Show < Trailblazer::Operation
    class ShowRepresenter < Representable::Decorator
      include JSON

      property :name
      property :area
      property :center_lat
      property :center_lon
    end
  end
end
