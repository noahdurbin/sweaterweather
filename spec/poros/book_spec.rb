require 'rails_helper'

RSpec.describe 'Book Poro' do
  describe 'initialize' do
    it 'can create a new book object' do
      book = Book.new({isbn: 123456, title: "title", publisher: "book publisher"})

      expect(book).to be_a Book
    end
  end

  describe 'methods' do
    it 'has attribute readers for instance variables' do
      book = Book.new({isbn: 123456, title: "title", publisher: "book publisher"})

      expect(book.isbn).to eq 123456
      expect(book.title).to eq "title"
      expect(book.publisher).to eq "book publisher"
    end
  end
end
