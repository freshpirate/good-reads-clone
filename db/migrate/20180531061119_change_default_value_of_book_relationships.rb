class ChangeDefaultValueOfBookRelationships < ActiveRecord::Migration
  def up
    change_column :book_relationships, :status_id, :integer, :default => 1
  end

  def down
    change_column :book_relationships, :status_id, :integer, :default => false
  end
end
