class Book
  attr_reader :isbn, :title, :publisher

  def initialize(book_hash)
    @isbn = book_hash[:isbn]
    @title = book_hash[:title]
    @publisher = book_hash[:publisher]
  end
end
