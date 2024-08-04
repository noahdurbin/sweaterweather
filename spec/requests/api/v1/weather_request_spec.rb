require 'rails_helper'

RSpec.describe 'retrieves the weather for given location' do
  it 'can retrieve the weather' do
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v1/forecast?location=Boulder,CO", headers: headers

    expect(response).to be_successful
    expect(response).to be(JSON)

    report = JSON.parse(response.body, symbolize_names: true)
    expect(report[:data]).to be_a(Hash)
    expect(report[:data][:id]).to eq(null)
    expect(report[:data][:type]).to eq(forecast)
    expect(report[:data][:attributes]).to have_key(:current_weather)
  end
end

# I can test specifically for what I don't want to see in this result, I should do the service spec first
