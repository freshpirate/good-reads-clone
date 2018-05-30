class Book < ActiveRecord::Base
  attr_accessible :author, :cover, :isbn_number, :language, :published_year, :publisher, :synopsis, :title
end
