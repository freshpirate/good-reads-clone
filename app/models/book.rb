class Book < ActiveRecord::Base
  #   attr_accessible :author, :cover, :isbn_number, :language,
  #     :published_year, :publisher, :synopsis,
  #     :title, :average_rating, :rating_count

  has_many :reviews, foreign_key: "book_id", dependent: :destroy
  has_many :user_book_statuses, foreign_key: :book_id, dependent: :destroy
  has_many :users, through: :reviews
end
