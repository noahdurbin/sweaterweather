class BookWeatherSerializer
  def initialize(weather_data, book_list, location)
    @weather_data = weather_data
    @book_list = book_list
    @location = locaton
  end

  def serialize_json
    {
      data: {
        id: nil,
        type: "books",
        attributes: {
          destination: @location,
          forecast: {
            summary: @weather_data.condition,
            temperature: @weather_data.temperature
          },
          total_books_found: @book_list.results_quantity,
          books: @book_list.book_array
        }
      }
    }
  end
end
