class BookFacade
  def search_books(location, quantity)
    weather = WeatherFacade.new.current_location(location)
    books = BookService.new.get_books(location, quantity)
   # serialize with both
  end
end
