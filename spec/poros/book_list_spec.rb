require 'rails_helper'

RSpec.describe 'book list' do
  describe 'initialize' do
    it 'can create a new book list' do
      book_hash = {
        numFound: 39,
        docs: [
          {
            isbn: 123456,
            title: "title",
            publisher: "book publisher"
          },
          {
            isbn: 12456,
            title: "book",
            publisher: "publisher of books"
          }
        ]
      }
      book_list = BookList.new(book_hash)

      expect(book_list).to be_a BookList
    end
  end
end
