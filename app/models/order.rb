class Order < ActiveRecord::Base
  attr_accessible :subtotal, :total, :discount

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
end
