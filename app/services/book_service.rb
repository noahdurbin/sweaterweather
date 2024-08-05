class BookService
  def conn
    Faraday.new(url: "https://openlibrary.org")
  end

  def get_books(location)
    response = conn.get("/search.json?q=#{location}")
    book_hash = JSON.parse(response.body, symbolize_names: true)
  end
end
