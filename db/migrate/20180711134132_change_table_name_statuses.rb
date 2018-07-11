class ChangeTableNameStatuses < ActiveRecord::Migration
  def up
    rename_table :statuses, :user_book_statuses
  end

  def down
    rename_table :user_book_statuses, :statuses
  end
end
