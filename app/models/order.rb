class Order < ActiveRecord::Base
  attr_accessible :subtotal, :total, :discount
end
