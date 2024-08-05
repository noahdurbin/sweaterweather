require 'rails_helper'

RSpec.describe 'retrieves weather and books for a location' do
  it 'can take a city as an input and give back related books and the current weather', :vcr do
    get "/api/v1/book-search?location=dever,co&quantity=5"

    expect(response).to be_successful
    report = JSON.parse(response.body, symbolize_names: true)

    expect(report).to have_key(:data)
    expect(report.count).to eq 1

    expect(report[:data]).to have_key :id
    expect(report[:data][:id]).to eq nil
    expect(report[:data][:type]).to eq "books"

    expect(report[:data]).to have_key :attributes
    expect(report[:data][:attributes].count).to eq 4
    expect(report[:data][:attributes][:destination]).to eq "denver,co"
    expect(report[:data][:attributes][:forecast].count).to eq 2
    expect(report[:data][:attributes][:forecast]).to have_key :summary
    expect(report[:data][:attributes][:forecast]).to have_key :temperature

    expect(report[:data][:attributes]).to have_key :total_books_found
    expect(report[:data][:attributes]).to have_key :books

    expect(report[:data][:attributes][:books]).to be_a Hash
    expect(report[:data][:attributes][:books].count).to eq 5
  end
end
