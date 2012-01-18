class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.references :user

      t.timestamps
    end
    add_index :books, :user_id
  end
end
