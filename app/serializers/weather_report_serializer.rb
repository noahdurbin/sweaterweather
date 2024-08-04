class WeatherReportSerializer
  def initialize(weather_data)
    @weather_data = weather_data
  end

  def serialize_json
    {
      data: {
        id: nil,
        type: "forecast",
        attributes: {
          current_weather: {
            last_updated: @weather_data.last_updated,
            temperature: @weather_data.temperature,
            feels_like: @weather_data.feels_like,
            humidity: @weather_data.humidity,
            uvi: @weather_data.uvi,
            visibility: @weather_data.visibility,
            condition: @weather_data.condition,
            icon: @weather_data.icon
          },
          daily_weather: @weather_data.daily_weather_array,
          hourly_weather: @weather_data.hourly_weather_array
        }
      }
    }
  end
end
