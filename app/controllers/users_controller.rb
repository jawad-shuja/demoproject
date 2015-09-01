class UsersController < ApplicationController
  before_filter :set_user, only: [:show]
  before_filter :authenticate_user!, only: [:dashboard]

  add_breadcrumb 'Home', :root_path

  def show
    add_breadcrumb @user.full_name
    @products = @user.products.ordered.page(params[:page]).per(Product::PER_PAGE)
    respond_to do |format|
      format.html
    end
  end

  def dashboard
    add_breadcrumb current_user.full_name
    @products = current_user.products.ordered.page(params[:product_page]).per(Product::PER_PAGE)
    @reviews = current_user.reviews.includes(:product).ordered.page(params[:review_page]).per(Review::PER_PAGE)

    respond_to do |format|
      format.html
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
