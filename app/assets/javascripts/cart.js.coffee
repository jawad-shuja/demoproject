$(document).ready ->
  $('.add-btn').click ->
    $.cookie.json = true
    id = $(this).data('id')
    cart = []
    total = 0
    sub_total = 0
    if $.cookie('cart') == null
      $.cookie 'cart', cart
      $.cookie 'total', total
      $.cookie 'subtotal', sub_total
    else
      cart = $.cookie('cart')
      total = $.cookie('total')
      sub_total = $.cookie('subtotal')

    if cart.indexOf(id) < 0
      cart.push id
      price = parseFloat($('#add-' + id).data('price'))
      sub_total = parseFloat(sub_total) + price
      total = parseFloat(total) + price
      $.cookie 'cart', cart
      $.cookie 'total', total
      $.cookie 'subtotal', sub_total
      $('.modal-body').text 'Product has been added to cart!'
      $('#cart-count').text cart.length
      $('#add-' + id).fadeOut()
    return

  $('.remove-btn').click ->
    $.cookie.json = true
    id = $(this).data('id')
    cart = []
    total = 0
    subtotal = 0
    if $.cookie('cart') != null
      cart = $.cookie('cart')
      total = $.cookie('total')
      sub_total = $.cookie('subtotal')
      cart.splice $.inArray(id, cart), 1
      price = parseFloat($('#remove-' + id).data('price'))
      sub_total = parseFloat(sub_total) - price
      total = parseFloat(total) - price
      sub_total = 0 if sub_total < 0
      total = 0 if total < 0
      $.cookie 'cart', cart, path: '/'
      $.cookie 'subtotal', sub_total, path: '/'
      $.cookie 'total', total, path: '/'
      $('.modal-body').text $('#product-' + id + ' .title').text() + 'has been removed from the cart.'
      $('#product-' + id).fadeOut 200, ->
        $(this).remove()
        return
      $('#cart-count').text cart.length
      $('.price-subtotal').text sub_total
      $('.price-total').text total
    return
  return
