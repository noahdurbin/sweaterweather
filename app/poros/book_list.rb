class BookList
  attr_reader :results_quantity, :book_array

  def initialize(book_hash)
    @results_quantity = book_hash[:numFound]
    @book_array = set_book_array(book_hash[:docs])
  end

  def set_book_array(results)
    results.map do |result|
      Book.new(result)
    end
  end
end
