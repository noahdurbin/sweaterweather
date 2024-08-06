class WeatherFacade
  def current_weather(params)
      report = get_weather(params)
      WeatherReportSerializer.new(report).serialize_json
    end

    def get_weather(params)
      location = MapquestService.new.coordinates(params)
      report_hash = WeatherService.new.weather_report(location.coordinates)
      report = WeatherReport.new(report_hash)
    end
end
