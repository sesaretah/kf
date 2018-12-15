class CreateShippingCosts < ActiveRecord::Migration
  def change
    create_table :shipping_costs do |t|
      t.integer :province_id
      t.integer :business_id
      t.string :cost

      t.timestamps null: false
    end
  end
end
