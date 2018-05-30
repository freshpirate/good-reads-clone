class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|
      t.string :title
      t.string :isbn_number, unique: true
      t.string :author
      t.string :synopsis
      t.string :published_year
      t.string :language
      t.string :cover
      t.string :publisher

      t.timestamps
    end

    add_index :books, :isbn_number
  end

  def down
    drop_table :books
  end
end
