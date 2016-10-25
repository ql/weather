class Field < ActiveRecord::Base
  module Contract
    class Create < Reform::Form
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
  end
end
