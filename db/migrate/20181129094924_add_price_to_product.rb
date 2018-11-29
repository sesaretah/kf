class AddPriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :price, :string
    add_column :products, :currency, :string 
  end
end
