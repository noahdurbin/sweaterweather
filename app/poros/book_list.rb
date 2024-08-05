class BookList
  attr_reader :results_quantity, :book_array

  def initialize(book_hash, quantity)
    @results_quantity = book_hash[:numFound]
    @book_array = set_book_array(book_hash[:docs], quantity)
  end

  def set_book_array(results, quantity)
    results.first(quantity).map do |result|
      Book.new(result)
    end
  end
end
