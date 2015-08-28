class OrdersController < ApplicationController
  before_filter :set_order, only: [:show, :destroy]

  respond_to :html

  def show
    respond_with(@order)
  end

  def checkout
    if signed_in?
      respond_with(@order)
    else
      session[:checkout] = true
      redirect_to new_user_session_path
    end
  end

  def destroy
    @order.destroy
    flash[:notice] = 'Order has been deleted.'
    respond_with(@order)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end
end
