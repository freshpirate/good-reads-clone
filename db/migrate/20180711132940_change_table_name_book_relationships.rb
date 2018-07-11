class ChangeTableNameBookRelationships < ActiveRecord::Migration
  def up
    rename_table :book_relationships, :reviews
  end

  def down
    rename_table :reviews, :book_relationships
  end
end
