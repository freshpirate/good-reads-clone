class BookRelationship < ActiveRecord::Base
  attr_accessible :book_id, :rating, :review, :status_id, :user_id
  belongs_to :user, class_name: "User"
  belongs_to :book, class_name: "Book"
  has_one :status_category

  validates :user_id, presence: true
  validates :book_id, presence: true
  # validates :status_id, presence: true
end
