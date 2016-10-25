class Field < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    model Field, :create

    contract do
      property :name
      property :boundary
      property :area
      property :center_lat
      property :center_lon

      validates :name, presence: true
      validate :boundary do |model|
        begin
          processor = ::FieldProcessorService.new(model.boundary)

          center = processor.centroid
          model.area = processor.area
          model.center_lat = center.lat
          model.center_lon = center.lon
        rescue StandardError => e
          errors.add(:boundary, "Invalid boundary: #{e.message}")
        end
      end

      validates :area, presence: true, numericality: { greater_than: 0 }
      validates :area, presence: true, numericality: { greater_than: 0 }
      validates :center_lat, presence: true
      validates :center_lon, presence: true
    end

    def process(params)
      validate(params[:field]) do |f|
        f.save
      end
    end
  end

  class Show < Trailblazer::Operation
    include Model
    model Field, :find

    include Trailblazer::Operation::Representer
    representer ShowRepresenter

    def process(*)
    end
  end

  class Update < Trailblazer::Operation
    include Model
  end

  class Delete < Trailblazer::Operation
    include Model
  end
end
