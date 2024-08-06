class WeatherFacade
  def current_weather(params)
    if params[:location] == ""
      ErrorSerializer.new(ErrorMessage.new("Must Provide Location", 404))
    else
      report = get_weather(params[:location])
      WeatherReportSerializer.new(report).serialize_json
    end
  end

  def get_weather(params)
    location = MapquestService.new.coordinates(params)
    report_hash = WeatherService.new.weather_report(location.coordinates)
    report = WeatherReport.new(report_hash)
  end
end
