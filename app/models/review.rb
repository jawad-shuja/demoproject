class Review < ActiveRecord::Base
  PER_PAGE = 5
  belongs_to :product
  belongs_to :user
  attr_accessible :body

  validates :body, presence: true, length: { minimum: 5, maximum: 300 }
  scope :ordered, -> { order('created_at DESC') }
end
