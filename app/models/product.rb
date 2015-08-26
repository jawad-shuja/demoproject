class Product < ActiveRecord::Base
  PER_PAGE = 5
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products
  belongs_to :user
  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :title, presence: true, length: { minimum: 5, maximum: 70 }
  validates :body, presence: true, length: { minimum: 25, maximum: 300 }
  validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }

  attr_accessible :body, :price, :title, :attachments_attributes
  scope :ordered, -> { order('created_at DESC') }
end
