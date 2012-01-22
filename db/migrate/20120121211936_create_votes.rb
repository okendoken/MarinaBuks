class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :book
      t.references :user

      t.timestamps
    end
    add_index :votes, :book_id
    add_index :votes, :user_id
  end
end
