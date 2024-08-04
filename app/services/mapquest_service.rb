class MapquestService
  def conn = Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
    faraday.params['key'] = Rails.application.credentials.maps[:access_key]
  end

  def coordinates(location)
    response = conn.get("/geocoding/v1/address?location=#{location}")
    location_hash = JSON.parse(response.body, symbolize_names: true)
    Location.new(location_hash)
  end
end
