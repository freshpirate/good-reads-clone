class ChangeColumnTypeOfBooks < ActiveRecord::Migration
  def change
    change_column :books, :average_rating, :float
  end
end
