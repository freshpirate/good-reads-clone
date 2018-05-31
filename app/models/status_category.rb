class StatusCategory < ActiveRecord::Base
  attr_accessible :name
  belongs_to :book_relationship
end
