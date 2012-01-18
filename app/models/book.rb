class Book < ActiveRecord::Base
  belongs_to :user

  def full_name
    "#{self.title} by #{self.author}"
  end
end
