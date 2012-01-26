class BooksController < ApplicationController
  autocomplete :book, :title, :extra_data => [:author], :full => true
  autocomplete :book, :author

  def autocomplete_for_book_author
    Book.select('distinct author')
  end

  #accessed via ajax
  def vote
    book_1 = Book.where(:id => params[:book_id_1])[0]
    book_2 = Book.where(:id => params[:book_id_2])[0]
    session["chosen_book_1"] = book_1
    session["chosen_book_2"] = book_2
    if book_1.nil? or book_2.nil?
      session["chosen_book_1"] = book_1.nil? ? Book.new(:title => params[:title_1]) : session["chosen_book_1"]
      session["chosen_book_2"] = book_2.nil? ? Book.new(:title => params[:title_2]) : session["chosen_book_2"]
      render :text => '/add_please'
    else
      session["books"] = [book_1, book_2]
      render :text => 'ok'
    end
  end

  def thank_you
    @books = Book.all(:order => 'vote_count desc', :limit => 100, :conditions => "vote_count != 0")
  end

  #accessed via ajax
  def create
    #todo crappy code. replace someday
    book_1 = Book.where(:id => params[:book_id_1])[0]
    if book_1.nil?
      book_1 = Book.new(:title => params[:title_1], :author => params[:author_1])
    end
    book_2 = Book.where(:id => params[:book_id_2])[0]
    if book_2.nil?
      book_2 = Book.new(:title => params[:title_2], :author => params[:author_2])
    end
    session["books"] = [book_1, book_2]
    render :text => 'ok'
  end

  def add_please
    @book_1 = session["chosen_book_1"]
    @book_2 = session["chosen_book_2"]
  end
end
