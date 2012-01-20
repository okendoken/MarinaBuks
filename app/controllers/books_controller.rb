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
      #book = books[0]
      session["chosen_book"] = books[0]
      #book.vote_count = book.vote_count + 1
      #book.save
      #redirect_to '/thank_you'
      #redirect_to user_omniauth_authorize_path(:facebook), :display => "popup", :"data-width" => 600, :"data-height" => 400
      render :text => 'ok'
    end
  end

  def thank_you
    @books = Book.all(:order => 'vote_count desc', :limit => 50)
  end
end
