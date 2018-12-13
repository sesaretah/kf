class AddOrderStatusIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :order_status_id, :integer
  end
end
