class CartController < ApplicationController
  def index
    @total = cookies[:total].to_f
    @sub_total = cookies[:subtotal].to_f
    @cart = cookies[:cart] ? JSON.parse(cookies[:cart]) : []
    @products = Product.find_all_by_id(@cart)
  end
end
