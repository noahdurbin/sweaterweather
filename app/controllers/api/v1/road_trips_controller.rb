class Api::V1::RoadTripsController < ApplicationController
  before_action :authenticate_key, only: [:create]

  def create
    render json: RoadTripFacade.new.new_trip(params)
  end

  private

  def authenticate_key
    binding.pry
    api_key = params[:api_key]
    @api_key = User.find_by(api_key: api_key)

    unless @api_key
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
