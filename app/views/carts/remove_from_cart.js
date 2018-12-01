$("#remove_from_cart").replaceWith("<%= escape_javascript(render(:partial => 'carts/remote_form', locals: {cart: @cart})) %>");
$("#cart-header").replaceWith("<%= escape_javascript(render(:partial => 'carts/cart_header', locals: {cart: @cart})) %>");
