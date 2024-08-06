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

    it 'can take two cities and calculate, driving time, and weather upon arrival for other cities', :vcr do
      user1 = User.create!(email: 'user1@test.com', password: 'password', password_confirmation: 'password', api_key: SecureRandom.hex)

      road_trip_body = {
        origin: "Denver,CO",
        destination: "Colorado Springs,CO",
        api_key: user1.api_key
      }
      post '/api/v1/road_trip', params: road_trip_body

      expect(response).to be_successful
    end

    it "contains the expected response body" do
      VCR.use_cassette "/Road_Trip/road_trip_endpoint/needs_an_api_to_function" do
        user1 = User.create!(email: 'user1@test.com', password: 'password', password_confirmation: 'password', api_key: SecureRandom.hex)

        road_trip_body = {
          origin: "New York,NY",
          destination: "Los Angeles,CA",
          api_key: user1.api_key
        }
        post '/api/v1/road_trip', params: road_trip_body
        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response).to have_key :data
        expect(json_response[:data]).to have_key :id
        expect(json_response[:data][:id]).to eq nil
        expect(json_response[:data]).to have_key :type
        expect(json_response[:data][:type]).to eq 'road_trip'
        expect(json_response[:data].count).to eq 3
        expect(json_response[:data]).to have_key :attributes
        expect(json_response[:data][:attributes]).to have_key :start_city
        expect(json_response[:data][:attributes]).to have_key :end_city
        expect(json_response[:data][:attributes]).to have_key :travel_time
        expect(json_response[:data][:attributes]).to have_key :weather_at_eta
        expect(json_response[:data][:attributes].count).to eq 4
        expect(json_response[:data][:attributes][:weather_at_eta]).to have_key :datetime
        expect(json_response[:data][:attributes][:weather_at_eta]).to have_key :temperature
        expect(json_response[:data][:attributes][:weather_at_eta]).to have_key :condition
        expect(json_response[:data][:attributes][:weather_at_eta].count).to eq 3
      end
    end

    it 'gives the correct response for an impossible trip', :vcr do
      user1 = User.create!(email: 'user1@test.com', password: 'password', password_confirmation: 'password', api_key: SecureRandom.hex)
      road_trip_body = {
        origin: "New York,NY",
        destination: "London,UK",
        api_key: user1.api_key
      }
      post '/api/v1/road_trip', params: road_trip_body
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to eq({
          "data": {
              "id": nil,
              "type": "road_trip",
              "attributes": {
                  "start_city": "New York,NY",
                  "end_city": "London,UK",
                  "travel_time": "impossible",
                  "weather_at_eta": {}
              }
          }
      })
    end

    it 'can calculate a response for a trip over 24 hours', :vcr do
      user1 = User.create!(email: 'user1@test.com', password: 'password', password_confirmation: 'password', api_key: SecureRandom.hex)
      road_trip_body = {
        origin: "New York,NY",
        destination: "Panama City,Panama",
        api_key: user1.api_key
      }
      post '/api/v1/road_trip', params: road_trip_body

      expect(response).to be_successful
    end
  end
end
