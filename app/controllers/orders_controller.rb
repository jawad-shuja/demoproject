class OrdersController < ApplicationController
  before_filter :set_order

  respond_to :html

  def show
    respond_with(@order)
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
