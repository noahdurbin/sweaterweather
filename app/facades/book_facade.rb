class BookFacade
  def search_books(location, quantity)
    weather = WeatherFacade.new.get_weather(location) # this is giving me WeatherRepor
    book_hash = BookService.new.get_books(location, quantity) #
    books = BookList.new(book_hash)
    results = BookWeatherSerializer.new(weather, books, location).serialize_json
  end
end
