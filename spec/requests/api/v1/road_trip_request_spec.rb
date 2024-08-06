require 'rails_helper'

RSpec.describe 'Road Trip' do
  describe 'road_trip endpoint' do
    it 'needs an api key to function', :vcr do
      user1 = User.create!(email: 'user1@test.com', password: 'password', password_confirmation: 'password', api_key: SecureRandom.hex)

      road_trip_body = {
        origin: "New York,NY",
        destination: "Los Angeles,CA",
        api_key: user1.api_key
      }
      post '/api/v1/road_trip', params: road_trip_body

      expect(response).to be_successful
    end

    it 'can take two cities and calculate, driving time, and weather upon arrival', :vcr do
      user1 = User.create!(email: 'user1@test.com', password: 'password', password_confirmation: 'password', api_key: SecureRandom.hex)

      road_trip_body = {
        origin: "New York,NY",
        destination: "Los Angeles,CA",
        api_key: SecureRandom.hex
      }
      post '/api/v1/road_trip', params: road_trip_body

      expect(response).to_not be_successful
    end
  end
end
