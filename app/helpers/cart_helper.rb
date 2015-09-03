module CartHelper
  def cart_items_count
    cookies[:cart] ? JSON.parse(cookies[:cart]).size : 0
  end

  def cart_empty?
    cart_items_count == 0 ? true : false
  end

  def item_in_cart?(item)
    cookies[:cart] ? JSON.parse(cookies[:cart]).include?(item.id) : false
  end

  def image_icon(index)
    index == 0 ? '<span class="glyphicon glyphicon-camera"></span>'.html_safe : ''
  end
end
