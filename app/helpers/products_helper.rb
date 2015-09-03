module ProductsHelper
  def photo_url(product, size)
    product.attachments.present? ? product.attachments.first.photo.url(size) : "missing_#{size}.png"
  end

  def default_photo(size)
    "missing_#{size}.png"
  end
end
