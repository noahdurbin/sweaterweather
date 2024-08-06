require 'rails_helper'

RSpec.describe 'retrieves the weather for given location' do
  it 'can retrieve the weather', :vcr do
    get "/api/v1/forecast?location=Boulder,CO"

    expect(response).to be_successful
    report = JSON.parse(response.body, symbolize_names: true)

    expect(report).to have_key(:data)
    expect(report.count).to eq 1

    expect(report[:data]).to have_key(:id)
    expect(report[:data][:id]).to eq nil
    expect(report[:data]).to have_key(:type)
    expect(report[:data][:type]).to eq "forecast"

    expect(report[:data]).to have_key :attributes
    expect(report[:data][:attributes]).to be_a Hash
    expect(report[:data][:attributes].count).to eq 3
    expect(report[:data][:attributes][:current_weather].count).to eq 8

    expect(report[:data][:attributes][:daily_weather]).to be_a Array
    expect(report[:data][:attributes][:daily_weather].count).to eq 5
    expect(report[:data][:attributes][:hourly_weather]).to be_a Array
    expect(report[:data][:attributes][:hourly_weather].count).to eq 24

    expect(report[:data][:attributes][:daily_weather].first.count).to eq 8
    expect(report[:data][:attributes][:hourly_weather].first.count).to eq 4
  end

  it 'requires user to provide a location', :vcr do
    get "/api/v1/forecast?location="

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response).to eq(
      {
          "error": {
              "message": "Must Provide Location",
              "status": 404
          }
      }
    )
  end
end
