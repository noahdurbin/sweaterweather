require 'rails_helper'

RSpec.describe 'retrieves weather and books for a location' do
  it 'can take a city as an input and give back related books and the current weather' do
    get "/api/v1/book-search?location=dever,co&quantity=5"

    expect(response).to be_successful
    report = JSON.parse(response.body, symbolize_names: true)

    expect(report).to have_key(:data)
    expect(report.count).to eq 1

    expect(report[:data]).to have_key :id
    expect(report[:data][:id]).to eq nil
    expect()
  end
end
