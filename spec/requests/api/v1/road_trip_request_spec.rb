require 'rails_helper'

RSpec.describe 'Road Trip' do
  describe 'road_trip endpoint' do
    it 'needs an api key to function' do
      user1 = User.new(email: 'user1@test.com', password: 'password', password_confirmation: 'password')
      user1.api_key = SecureRandom.hex

      road_trip_body = {
        origin: "Cincinatti,OH",
        destination: "Chicago,IL",
        api_key: user1.api_key
      }
      post '/api/v1/road_trip', params: road_trip_body

      expect(response).to be_successful
    end

    it 'can take two cities and calculate, driving time, and weather upon arrival' do
    end
  end
end
