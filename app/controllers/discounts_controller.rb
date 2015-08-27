class DiscountsController < ApplicationController
  def validate
    @discount = Discount.find_by_coupon(params[:coupon])
    @discount_percentage = 1 - (Discount::DISCOUNT_PERCENTAGE.to_f / 100)
    respond_to do |format|
      format.js
    end
  end
end
