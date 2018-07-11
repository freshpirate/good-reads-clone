class ChangeColumnNameAndTypeOfReview < ActiveRecord::Migration
  def up
    rename_column :reviews, :status, :status_id
    change_column :reviews, :status_id, :integer
  end

  def down
    change_column :reviews, :status_id, :string
    rename_column :reviews, :status_id, :status
  end
end
