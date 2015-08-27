class Discount < ActiveRecord::Base
  DISCOUNT_PERCENTAGE = 10
  attr_accessible :coupon, :is_valid
end
