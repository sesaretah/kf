class Cart < ActiveRecord::Base
  has_many :products, :through => :cart_items
  has_many :cart_items, dependent: :destroy


  def inkludes(product)
    @cart_items = self.cart_items.where(product_id: product.id)
    if @cart_items.blank?
      return false
    else
      return true
    end
  end
end
