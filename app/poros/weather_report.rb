class WeatherReport
  attr_reader :last_updated, :temperature, :feels_like, :humidity,
              :uvi, :visibility, :condition, :icon, :daily_weather_array,
              :hourly_weather_array

  def initialize(weather_data)
    @last_updated = weather_data[:current][:last_updated]
    @temperature = weather_data[:current][:temp_f]
    @feels_like = weather_data[:current][:feelslike_f]
    @humidity = weather_data[:current][:humidity]
    @uvi = weather_data[:current][:uv]
    @visibility = weather_data[:current][:vis_miles]
    @condition = weather_data[:current][:condition][:text]
    @icon = weather_data[:current][:condition][:icon]
    @daily_weather_array = set_daily_weather_array(weather_data[:forecast][:forecastday])
    @hourly_weather_array = set_hourly_weather_array(weather_data[:forecast][:forecastday].first[:hour])
  end

  def set_daily_weather_array(days)
    days.map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def set_hourly_weather_array(hours)
    hours.map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        condition: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end
