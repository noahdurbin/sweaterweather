require 'rails_helper'

RSpec.describe 'weather service' do
  it 'has the 3 main response fields', :vcr do
    service = WeatherService.new
    response = service.weather_report('40.01574,-105.27924')

    expect(response).to have_key(:location)
    expect(response).to have_key(:current)
    expect(response).to have_key(:forecast)
  end

  it 'returns current weather data and no extra data' do
    VCR.use_cassette("/weather_service/has_the_3_main_response_fields") do
      service = WeatherService.new
      response = service.weather_report('40.01574,-105.27924')

      expect(response[:current]).to have_key(:temp_f)
      expect(response[:current]).to have_key(:condition)
      expect(response[:current][:condition].count).to eq 2
      expect(response[:current]).to have_key(:humidity)
      expect(response[:current]).to have_key(:feelslike_f)
      expect(response[:current]).to have_key(:vis_miles)
      expect(response[:current]).to have_key(:uv)
      expect(response[:current].count).to eq 7
    end
  end

  it 'returns exactly 5 days of forecast data' do
    VCR.use_cassette("/weather_service/has_the_3_main_response_fields") do
      service = WeatherService.new
      response = service.weather_report('40.01574,-105.27924')

      expect(response[:forecast][:forecastday].count).to eq(5)
    end
  end

  it 'contains 24 hours of data for current day' do
    VCR.use_cassette("/weather_service/has_the_3_main_response_fields") do
      service = WeatherService.new
      response = service.weather_report('40.01574,-105.27924')

      expect(response[:forecast][:forecastday].first[:hour].count).to eq(24)
    end
  end

  it 'check fields of what is wanted and not wanted for hourly data' do
    VCR.use_cassette("/weather_service/has_the_3_main_response_fields") do
      service = WeatherService.new
      response = service.weather_report('40.01574,-105.27924')

      expect(response[:forecast][:forecastday].first[:hour].first).to have_key(:time)
      expect(response[:forecast][:forecastday].first[:hour].first).to have_key(:temp_f)
      expect(response[:forecast][:forecastday].first[:hour].first).to_not have_key(:humidity)
      expect(response[:forecast][:forecastday].first[:hour].first).to_not have_key(:cloud)
      expect(response[:forecast][:forecastday].first[:hour].first).to_not have_key(:cloud)
    end
  end

  it 'includes sunrise and sunset data and nothing else' do
    VCR.use_cassette("/weather_service/has_the_3_main_response_fields") do
      service = WeatherService.new
      response = service.weather_report('40.01574,-105.27924')

      expect(response[:forecast][:forecastday].first[:astro]).to have_key(:sunrise)
      expect(response[:forecast][:forecastday].first[:astro]).to have_key(:sunset)
      expect(response[:forecast][:forecastday].first[:astro]).to_not have_key(:moonrise)
      expect(response[:forecast][:forecastday].first[:astro]).to_not have_key(:moonset)
      expect(response[:forecast][:forecastday].first[:astro]).to_not have_key(:moon_illumination)
      expect(response[:forecast][:forecastday].first[:astro]).to_not have_key(:is_sun_up)
      expect(response[:forecast][:forecastday].first[:astro]).to_not have_key(:is_moon_up)
      expect(response[:forecast][:forecastday].first[:astro]).to_not have_key(:moon_phase)
    end
  end
end
