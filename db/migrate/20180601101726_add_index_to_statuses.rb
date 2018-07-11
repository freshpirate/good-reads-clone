class AddIndexToUserBookStatuses < ActiveRecord::Migration
  def change
    remove_index :statuses, [:book_id, :status_id]
    add_index :statuses, [:book_id, :user_id], unique: true
  end
end
