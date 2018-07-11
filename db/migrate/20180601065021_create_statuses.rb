class CreateUserBookStatuses < ActiveRecord::Migration
  def up
    create_table :statuses do |t|
      t.integer :book_id
      t.integer :user_id
      t.integer :status_id

      t.timestamps
    end

    add_index :statuses, :book_id
    add_index :statuses, :user_id
    add_index :statuses, :status_id
    add_index :statuses, [:book_id, :status_id], unique: true

  end

  def down
    drop_table :statuses
  end
end
