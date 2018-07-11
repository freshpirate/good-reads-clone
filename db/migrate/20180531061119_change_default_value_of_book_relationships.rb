class ChangeDefaultValueOfReviews < ActiveRecord::Migration
  def up
    change_column :reviews, :status_id, :integer, :default => 1
  end

  def down
    change_column :reviews, :status_id, :integer, :default => false
  end
end
