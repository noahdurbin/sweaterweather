class RoadTripSerializer
  def initialize(trip, weather_on_arrival)
    @trip = trip
    @weather_on_arrival = weather_on_arrival
    @travel_time = trip.travel_time
  end

  def serialize_json
    {
      data: {
        id: nil,
        type: "road_trip",
        attributes: {
          start_city: @trip.start,
          end_city: @trip.end,
          travel_time: @trip.travel_time,
          weather_at_eta: weather_data
        }
      }
    }
  end

  private

  def weather_data
    return {} if @weather_on_arrival.nil?

    if @weather_on_arrival[:date]
      {
        datetime: @weather_on_arrival[:date],
        temperature: @weather_on_arrival[:avg_temp],
        condition: @weather_on_arrival[:condition]
      }
    else
      {
        datetime: @weather_on_arrival[:time],
        temperature: @weather_on_arrival[:temperature],
        condition: @weather_on_arrival[:condition],
      }
    end
  end
end
