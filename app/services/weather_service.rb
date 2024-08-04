class WeatherService
  def conn
    Faraday.new(url: "https://api.weatherapi.com") do |faraday|
      faraday.params['key'] = Rails.application.credentials.weather[:access_key]
    end
  end

  def weather_report(coordinates)
    response = conn.get("/v1/forecast.json?q=#{coordinates}&days=5")
    weather_hash = JSON.parse(response.body, symbolize_names: true)
  end
end
