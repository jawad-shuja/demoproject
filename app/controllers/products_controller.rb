class ProductsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :set_product, only: [:show, :edit, :update, :destroy]

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
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = current_user.products.new(params[:product])
    @product.save
    respond_with(@product)
  end

  def update
    @product.update_attributes(params[:product])
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
end
