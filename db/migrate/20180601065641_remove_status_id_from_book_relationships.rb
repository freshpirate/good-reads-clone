class RemoveStatusIdFromBookRelationships < ActiveRecord::Migration
  def up
    remove_column :book_relationships, :status_id
  end

  def down
    add_column :book_relationships, :status_id, :integer, default: 4
  end
end
