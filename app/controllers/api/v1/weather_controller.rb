class Api::V1::WeatherController < ApplicationController
  def forecast
    render json: WeatherFacade.new.current_weather(params)
  end
end
