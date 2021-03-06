class Book < ActiveRecord::Base
  attr_accessible :author, :cover, :isbn_number, :language, :published_year, :publisher, :synopsis, :title, :average_rating, :rating_count
  has_many :book_relationships, foreign_key: "book_id", dependent: :destroy
  has_many :statuses, foreign_key: :book_id, dependent: :destroy
  has_many :users, through: :book_relationships
end
