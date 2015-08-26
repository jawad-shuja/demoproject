module CartHelper
  def cart_items_count
    cookies[:cart] ? JSON.parse(cookies[:cart]).size : 0
  end

  def item_in_cart?(item)
    cookies[:cart] ? JSON.parse(cookies[:cart]).include?(item.id) : false
  end
end
