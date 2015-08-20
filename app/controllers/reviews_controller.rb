class ReviewsController < ApplicationController
  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :set_product
  before_filter :restrict_owner, except: [:index, :show, :destroy]
  respond_to :html

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = @product.reviews.new(params[:review])
    @review.user = current_user
    respond_to do |format|
      if @review.save
        format.html { redirect_to product_reviews_path(@product) }
      else
        format.html { render :new }
      end
      format.js
    end
  end

  def update
    @review.update_attributes(params[:review])
    respond_with(@product, @review)
  end

  def destroy
    @review.destroy
    respond_with(@product, @review)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def restrict_owner
      if owner?(@product.user_id)
        flash[:notice] = "You cannot review your own product!"
        redirect_to product_path(@product)
      end
    end
end
