$(document).ready ->
  $('.add-btn').click ->
    $.cookie.json = true
    id = $(this).data('id')
    cart = []
    total = 0
    if $.cookie('cart') == null
      $.cookie 'cart', cart
      $.cookie 'total', total
    else
      cart = $.cookie('cart')
      total = $.cookie('subtotal')

    if cart.indexOf(id) < 0
      cart.push id
      total = parseFloat(total) + parseFloat($('#add-' + id).data('price'))
      $.cookie 'cart', cart
      $.cookie 'subtotal', total
      $.cookie 'total', total
      $('.modal-body').text 'Product has been added to cart!'
      $('#cart-count').text cart.length
      $('#add-' + id).fadeOut()
    return

  $('.remove-btn').click ->
    $.cookie.json = true
    id = $(this).data('id')
    cart = []
    total = 0
    if $.cookie('cart') != null
      cart = $.cookie('cart')
      total = $.cookie('subtotal')
      cart.splice $.inArray(id, cart), 1
      total = parseFloat(total) - parseFloat($('#remove-' + id).data('price'))
      $.cookie 'cart', cart, path: '/'
      $.cookie 'subtotal', total, path: '/'
      $.cookie 'total', total, path: '/'
      $('.modal-body').text $('#product-' + id + ' .title').text() + 'has been removed from the cart.'
      $('#product-' + id).fadeOut 200, ->
        $(this).remove()
        return
      $('#cart-count').text cart.length
      $('.price-subtotal').text total
      $('.price-total').text total
    return
  return
