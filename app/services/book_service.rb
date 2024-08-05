class BookService
  def conn
    Faraday.new(url: "https://openlibrary.org")
  end

  def get_books(location, quantity)
    response = conn.get("/search.json?title=#{location}&limit=#{}quantity")
    book_hash = JSON.parse(response.body, symbolize_names: true)
  end
end
