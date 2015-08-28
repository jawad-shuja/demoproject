class ProductsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :validate_user, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @products = Product.ordered.page(params[:page]).per(Product::PER_PAGE)
    respond_with(@products)
  end

  def show
    @review = Review.new
    respond_with(@product)
  end

  def new
    @product = Product.new
    @product.attachments.build
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = current_user.products.new(params[:product])
    if @product.save
      flash[:success] = 'Product has been created successfully.'
    end
    respond_with(@product)
  end

  def update
    @product.update_attributes(params[:product])
    respond_with(@product)
  end

  def destroy
    @product.destroy
    flash[:notice] = 'Product has been deleted.'
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def validate_user
      unless owner?(@product.user_id)
        redirect_to products_path, alert: "You cannot edit or delete this product!"
      end
    end

end
