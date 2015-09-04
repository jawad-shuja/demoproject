class ProductsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :validate_user, only: [:edit, :update, :destroy]

  respond_to :html

  add_breadcrumb 'Home', :root_path, except: :index
  add_breadcrumb 'Products', :products_path, except: :index

  def index
    if (params.has_key?(:search))
      @products = Product.perform_search({search: params[:search], order: 'created_at DESC', page: params[:page]})
    else
      @products = Product.ordered.page(params[:page]).per(Product::PER_PAGE)
    end
    respond_with(@products)
  end

  def show
    add_breadcrumb @product.title
    @review = Review.new
    respond_with(@product)
  end

  def new
    add_breadcrumb 'New'
    @product = Product.new
    respond_with(@product)
  end

  def edit
    add_breadcrumb @product.title, product_path(@product)
    add_breadcrumb 'Edit'
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
    redirect_to :back
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
