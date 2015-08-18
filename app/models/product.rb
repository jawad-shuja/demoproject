class Product < ActiveRecord::Base
  PER_PAGE = 5
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true
  attr_accessible :body, :price, :title, :attachments_attributes
  scope :ordered, -> { order('created_at DESC') }
end
