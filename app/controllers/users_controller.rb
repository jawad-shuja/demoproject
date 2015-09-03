class UsersController < ApplicationController
  before_filter :set_user, only: [:show]
  before_filter :authenticate_user!, only: [:dashboard]

  add_breadcrumb 'Home', :root_path

  def show
    add_breadcrumb @user.full_name
    @products = @user.get_products(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def dashboard
    add_breadcrumb current_user.full_name
    @products = current_user.get_products(params[:product_page])
    @reviews = current_user.get_reviews(params[:review_page])

    respond_to do |format|
      format.html
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
