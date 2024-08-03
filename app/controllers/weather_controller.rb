class WeatherController < ApplicationController
  def current_weather(location)
    @weather_report = WeatherFacade.current_weather(location)
  end
end
