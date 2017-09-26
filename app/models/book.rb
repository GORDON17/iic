class Book < ActiveRecord::Base
  attr_accessible :author, :categories, :lastCheckedOut, :lastCheckedOutBy, :publisher, :title, :url
end
