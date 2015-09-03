$(document).ready ->
  $('.add-btn').click ->
    $.cookie.json = true
    id = $(this).data('id')
    cart = []
    total = 0
    sub_total = 0
    if $.cookie('cart') == null
      $.cookie 'cart', cart, path: '/'
      $.cookie 'total', total, path: '/'
      $.cookie 'subtotal', sub_total, path: '/'
    else
      cart = $.cookie('cart')
      total = $.cookie('total')
      sub_total = $.cookie('subtotal')

    if cart.indexOf(id) < 0
      cart.push id
      price = parseFloat($('#add-' + id).data('price'))
      sub_total = parseFloat(sub_total) + price
      total = parseFloat(total) + price
      $.cookie 'cart', cart, path: '/'
      $.cookie 'total', total, path: '/'
      $.cookie 'subtotal', sub_total, path: '/'
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
      if cart.length == 0
        $('#cart-wrapper').empty()
        $('#cart-wrapper').append "<h1>Your cart is empty!</h1><a href='" + window.location.origin + "' class='btn btn-success'>Add Items Now!</a>"
      else
        $('#product-' + id).fadeOut 200, ->
          $(this).remove()
          return
        $('#cart-count').text cart.length
        $('.price-subtotal').text sub_total
        $('.price-total').text total
    return

  $('#checkout_link').click (event) ->
    if !$.cookie('cart') || $.cookie('cart').toString().length == 0 || $.parseJSON($.cookie('cart')).length == 0
      event.preventDefault()
      $('.modal-body').text 'The cart is empty!';
      $('#modal-link').trigger('click');
    return

  $('#cart_clear_link').click ->
    $.removeCookie('cart', { path: '/' })
    $.removeCookie('total', { path: '/' })
    $.removeCookie('subtotal', { path: '/' })
    $('#cart-count').text '0'
    $('#cart-wrapper').empty()
    $('#cart-wrapper').append "<h1>Your cart is empty!</h1><a href='" + window.location.origin + "' class='btn btn-success'>Add Items Now!</a>"
    return
  return
