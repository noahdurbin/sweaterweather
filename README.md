# SweaterWeather

SweaterWeather is a Rails API application that provides weather forecasts and road trip planning with weather information.

## Features

- User registration and authentication
- Current weather forecasts
- Hourly and daily weather forecasts
- Road trip planning with estimated travel time and weather at destination

## Setup

### Prerequisites

- Ruby 3.x
- Rails 7.x
- PostgreSQL

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/your-username/sweaterweather.git
   cd sweaterweather
   ```

2. Install dependencies:
   ```
   bundle install
   ```

3. Set up the database:
   ```
   rails db:create db:migrate
   ```

4. Set up environment variables:
   Create a `config/credentials.yml.enc` file with your API keys:
   ```
   EDITOR="vim" rails credentials:edit
   ```
   Add your API keys:
   ```yaml
   maps:
     access_key: your_mapquest_api_key
   weather:
     access_key: your_weatherapi_key
   ```

5. Start the server:
   ```
   rails server
   ```

## API Endpoints

### User Registration
- `POST /api/v1/users`

### User Login
- `POST /api/v1/sessions`

### Weather Forecast
- `GET /api/v1/forecast?location=denver,co`

### Road Trip
- `POST /api/v1/road_trip`

## Running Tests

```
bundle exec rspec
```

## Services Used

- MapQuest API for geocoding and directions
- WeatherAPI for weather forecasts

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
