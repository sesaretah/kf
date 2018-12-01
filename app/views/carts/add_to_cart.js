$("#add_to_cart").replaceWith("<%= escape_javascript(render(:partial => 'carts/add_to_cart', locals: {product: @product, cart: @cart})) %>");
$("#cart-header").replaceWith("<%= escape_javascript(render(:partial => 'carts/cart_header', locals: {cart: @cart})) %>");
