class FieldProcessorService
  PROJ4_RUSSIA_CODE = '+proj=aea +lat_1=50 +lat_2=70 +lat_0=56 +lon_0=100 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs '

  def initialize(geojson)
    @features = RGeo::GeoJSON.decode(geojson, json_parser: :json)
    @factory = RGeo::Geographic.projected_factory(projection_proj4: PROJ4_RUSSIA_CODE)
    raise "More than one feature" if @features.size > 1
  end

  def centroid
    projected_geometry(@features[0].geometry).centroid
  end

  def area
    projected_geometry(@features[0].geometry).area.round(2)
  end

private

  def projected_geometry(geometry)
    @rojected ||= RGeo::Feature.cast geometry, factory: @factory
  end
end
