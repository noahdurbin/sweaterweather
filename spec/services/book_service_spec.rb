require 'rails_helper'

RSpec.describe 'book service' do
  it 'has the main expected response keys', :vcr do
    service = BookService.new
    response = service.get_books("New York,CO", 10)

    expect(response).to have_key :numFound
    expect(response).to have_key :start
    expect(response).to have_key :docs
    expect(response).to have_key :numFoundExact
    expect(response).to have_key :num_found
    expect(response).to have_key :q
    expect(response).to have_key :offset
    expect(response.count).to eq 7
  end

  it 'returns the accurate amount of books' do
    VCR.use_cassette("/book_service/has_the_main_expected_response_keys") do
      service = BookService.new
      response = service.get_books("New York,CO", 10)

      expect(response[:docs].count).to eq 10
    end
  end
end
