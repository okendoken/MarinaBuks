class AddUiOrderColumnToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :ui_order, :integer
  end
end
