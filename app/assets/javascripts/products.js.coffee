$(document).ready ->
  $.validator.addMethod 'regex', ((value, element, regexpr) ->
    regexpr.test value
  ), 'Please enter a valid value.'

  $('#new_product').validate rules: 'product[price]':
    required: true
    regex: /\d+(?:\.\d{0,2})?/
    number: true
    min: 0
