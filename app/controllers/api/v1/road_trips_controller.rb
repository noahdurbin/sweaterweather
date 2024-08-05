class RoadTripsController < ApplicationController
  def create
    render json: RoadTripFacade.new.new_trip(params)
  end
end
