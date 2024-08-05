class BookFacade
  def search_books(location, quantity)
    weather = WeatherFacade.new.current_location(location) # this is giving me WeatherRepor
    book_hash = BookService.new.get_books(location) #
    books = BookList.new(book_hash, quantity)
    # serialize with both
  end
end
