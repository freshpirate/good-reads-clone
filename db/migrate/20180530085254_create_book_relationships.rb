class CreateBookRelationships < ActiveRecord::Migration
  def change
    create_table :book_relationships do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :status
      t.string :rating
      t.string :review

      t.timestamps
    end

    add_index :book_relationships, :user_id
    add_index :book_relationships, :book_id
    add_index :book_relationships, [:user_id, :book_id], unique: true
    add_index :book_relationships, [:user_id, :status]
  end
end
