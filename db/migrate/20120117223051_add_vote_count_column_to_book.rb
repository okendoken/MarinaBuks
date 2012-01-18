class AddVoteCountColumnToBook < ActiveRecord::Migration
  def change
    add_column :books, :vote_count, :integer, :default => 0
  end
end
