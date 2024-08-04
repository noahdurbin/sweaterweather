class Location
  attr_reader  :city, :state, :coordinates

  def initialize(location_hash)
    @city = location_hash[:results].first[:locations].first[:adminArea5]
    @state = location_hash[:results].first[:locations].first[:adminArea3]
    @coordinates = set_latlong(location_hash)
  end

  def set_latlong(location)
    coordinate_hash = location[:results].first[:locations].first[:latLng]
    "#{coordinate_hash[:lat]},#{coordinate_hash[:lng]}"
  end
end
