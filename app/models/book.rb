class Book < ActiveRecord::Base
  attr_accessible :author, :cover, :isbn_number, :language, :published_year, :publisher, :synopsis, :title
  has_many :book_relationships, foreign_key: "book_id", dependent: :destroy
end
