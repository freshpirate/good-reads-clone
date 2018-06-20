class AddAverageRatingColumnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :average_rating, :integer, default: 0
    add_column :books, :rating_count, :integer, default: 0    
  end
end
