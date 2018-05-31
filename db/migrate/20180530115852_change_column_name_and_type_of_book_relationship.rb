class ChangeColumnNameAndTypeOfBookRelationship < ActiveRecord::Migration
  def up
    rename_column :book_relationships, :status, :status_id
    change_column :book_relationships, :status_id, :integer
  end

  def down
    change_column :book_relationships, :status_id, :string
    rename_column :book_relationships, :status_id, :status
  end
end
