class RoadTripFacade
  def new_trip(params)
    trip = MapquestService.new.trip(params[:origin], params[:destination])

    if trip.nil?
      impossible_trip_response(params[:origin], params[:destination])
    else
      weather = WeatherFacade.new.get_weather(params[:destination])
      weather_on_arrival = weather.future_weather(trip.time)
      RoadTripSerializer.new(trip, weather_on_arrival).serialize_json
    end
  end

  private

  def impossible_trip_response(origin, destination)
    {
      data: {
        id: nil,
        type: "road_trip",
        attributes: {
          start_city: origin,
          end_city: destination,
          travel_time: "impossible",
          weather_at_eta: {}
        }
      }
    }
  end
end
