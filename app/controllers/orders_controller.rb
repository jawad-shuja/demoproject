class OrdersController < ApplicationController
  before_filter :authenticate_user!, except: [:checkout]
  before_filter :set_order, only: [:show, :destroy]
  before_filter :validate_user, only: [:show, :destroy]

  respond_to :html

  def index
    @orders = current_user.orders
    respond_with(@order)
  end

  def show
    respond_with(@order)
  end

  def checkout
    if signed_in?
      @order = Order.new
      respond_with(@order)
    else
      session[:checkout] = true
      redirect_to new_user_session_path
    end
  end

  def create
    response = Order.process_payment(cookies, current_user, params, auth)

    if response.success?
      @order = current_user.new_order cookies, params

      if @order.save
        cookies.delete :cart
        cookies.delete :total
        cookies.delete :subtotal
        flash[:success] = "Successfully made a purchase."
      end

      respond_with(@order)
    else
      flash[:error] = response.response_reason_text
      redirect_to checkout_orders_path
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

    def auth
      @@auth ||= YAML.load_file("#{Rails.root}/config/authorize_net.yml")[Rails.env]
    end

    def validate_user
      unless owner?(@order.user_id)
        redirect_to orders_path, alert: "You cannot see or remove this order!"
      end
    end
end
