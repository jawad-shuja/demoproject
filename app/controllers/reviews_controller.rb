class ReviewsController < ApplicationController
  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :set_product
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
    @review.save
    respond_to do |format|
      format.html { redirect_to product_reviews_path(@product) }
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
end
