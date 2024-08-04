class WeatherFacade
  def current_weather(params)
    location = MapquestService.new.coordinates(params)
    report = WeatherService.new.weather_report(location.coordinates)
    WeatherReportSerializer.new(report).serialize_json
  end
end
