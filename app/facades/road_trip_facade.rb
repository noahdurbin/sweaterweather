class RoadTripFacade
  def new_trip(params)
    trip = MapquestService.new.hours(params[:origin], params[:destination])
    weather = WeatherFacade.new.get_weather(params[:destination])
    weather_on_arrival = weather.future_weather(trip.time)
    RoadTripSerializer.new(trip, weather_on_arrival)
  end
end
