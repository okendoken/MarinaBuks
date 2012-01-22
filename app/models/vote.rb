class Vote < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  before_save :update_book

  private

  def update_book
    #optimizing performance
    self.book.increase_vote_count
    self.book.save
  end
end
