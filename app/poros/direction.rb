class Direction
  attr_reader :time, :travel_time, :start, :end

  def initialize(directions_hash)
    @time = seconds_to_hours(directions_hash[:route][:realtime])
    @travel_time = directions_hash[:route][:formattedTime]
    @start = set_location(directions_hash[:route][:locations].first)
    @end = set_location(directions_hash[:route][:locations].second)
  end

  def seconds_to_hours(seconds)
    (seconds.to_f / 3600).ceil
  end

  def set_location(locations)
    "#{[:adminArea5]}, #{[:adminArea3]}"
  end
end
