class DiscountsController < ApplicationController
  def validate
    @discount = Discount.find_by_coupon(params[:coupon])
    respond_to do |format|
      format.js
    end
  end
end
