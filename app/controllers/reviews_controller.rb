class ReviewsController < ApplicationController
  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :set_product
  before_filter :restrict_owner, except: [:index, :show, :destroy]
  before_filter :validate_user, only: [:edit, :update]
  before_filter :validate_product_owner, only: [:destroy]
  respond_to :html

  def index
    @reviews = @product.reviews
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
        flash[:success] = 'Your review has been sumbitted successfully.'
        format.html { redirect_to product_reviews_path(@product) }
      else
        format.html { render :new }
      end
      format.js
    end
  end

  def update
    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to(product_review_path(@product,@review), notice: 'Review was successfully updated.') }
        format.json { respond_with_bip(@review) }
      else
        format.html { render action:'edit' }
        format.json { respond_with_bip(@review) }
      end
    end
  end

  def destroy
    if @review.destroy
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Review has been deleted.' }
        format.js
      end
    end
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
        redirect_to product_path(@product), alert: 'You cannot review your own product!'
      end
    end

    def validate_user
      unless owner?(@review.user_id)
        redirect_to product_reviews_path(@product), alert: "You cannot edit this review!"
      end
    end

    def validate_product_owner
      unless owner?(@review.user_id) || owner?(@product.user_id)
        redirect_to product_reviews_path(@product), alert: "You cannot delete this review!"
      end
    end
end
