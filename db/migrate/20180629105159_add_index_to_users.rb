class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :persistence_token
  end
end
