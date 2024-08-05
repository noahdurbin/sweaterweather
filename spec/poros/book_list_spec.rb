require 'rails_helper'

RSpec.describe 'book list' do
  before(:all) do
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
    @book_list = BookList.new(book_hash)
  end

  describe 'initialize' do
    it 'can create a book list' do
      expect(@book_list).to be_a BookList
    end
  end

  describe 'methods' do
    it 'can read attributes' do
      expect(@book_list.results_quantity).to eq 39
    end
  end
end
