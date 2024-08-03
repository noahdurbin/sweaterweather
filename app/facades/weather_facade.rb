class WeatherFacade
  def current_weather(params)
    location = MapquestService.new.coordinates(params[:location])
    report = WeatherService.new.weather_report(location.coordinates)
  end
end
