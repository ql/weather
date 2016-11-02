require 'representable/json'

class Field < ActiveRecord::Base
  module Representer
    class Create < Representable::Decorator
      include JSON

      property :id
    end

    class Show < Representable::Decorator
      include JSON

      property :name
      property :area
      property :center_lat
      property :center_lon

      collection_representer class: Field

    end
  end
end
