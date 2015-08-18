class Product < ActiveRecord::Base
  PER_PAGE = 5
  attr_accessible :body, :price, :title
  scope :ordered, -> { order('created_at DESC') }
end
