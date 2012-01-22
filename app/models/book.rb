class Book < ActiveRecord::Base
  belongs_to :user

  def full_name
    "#{self.title} by #{self.author}"
  end

  def increase_vote_count
    self.vote_count = self.vote_count + 1
  end
end
