class Status < ActiveRecord::Base
  attr_accessible :book_id, :status_id, :user_id

  belongs_to :user, class_name: "User"
  belongs_to :book, class_name: "Book"
  belongs_to :status_category, foreign_key: :status_id

  validates :user_id, presence: true
  validates :book_id, presence: true
end
