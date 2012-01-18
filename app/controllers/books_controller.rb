class BooksController < ApplicationController
  autocomplete :book, :title

  def index
    @book = Book.new
  end

  def create
    books = Book.where(:id => params[:book][:id])
    if books.empty?
      redirect_to '/add_please'
    else
      book = books[0]
      book.vote_count = book.vote_count + 1
      book.save
      redirect_to '/thank_you'
    end
  end

  def thank_you
    @books = Book.all(:order => 'vote_count desc', :limit => 50)
  end
end
