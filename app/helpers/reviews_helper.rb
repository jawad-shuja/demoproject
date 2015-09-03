module ReviewsHelper
  def deletable?(review)
    owner?(review.user_id) || owner?(review.product.user_id)
  end
end
