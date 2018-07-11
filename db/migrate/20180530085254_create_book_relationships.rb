class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :status
      t.string :rating
      t.string :review

      t.timestamps
    end

    add_index :reviews, :user_id
    add_index :reviews, :book_id
    add_index :reviews, [:user_id, :book_id], unique: true
    add_index :reviews, [:user_id, :status]
  end
end
