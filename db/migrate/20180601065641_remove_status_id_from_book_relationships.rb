class RemoveStatusIdFromReviews < ActiveRecord::Migration
  def up
    remove_column :reviews, :status_id
  end

  def down
    add_column :reviews, :status_id, :integer, default: 4
  end
end
