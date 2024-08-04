class WeatherFacade
  def current_weather(params)
    location = MapquestService.new.coordinates(params)
    report_hash = WeatherService.new.weather_report(location.coordinates)
    report = WeatherReport.new(report_hash)
    WeatherReportSerializer.new(report).serialize_json
  end
end
