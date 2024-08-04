require 'rails_helper'

RSpec.describe 'mapquest service', :vcr do
  it 'can get the coordinates for a location' do
    service = MapquestService.new
    city = "Boulder, CO"
    response = service.coordinates(city)

    expect(response).to be_a Location
    expect((response).city).to eq("Boulder")
    expect((response).coordinates).to eq("40.01574,-105.27924")
  end
end
