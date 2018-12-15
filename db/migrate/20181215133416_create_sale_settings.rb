class CreateSaleSettings < ActiveRecord::Migration
  def change
    create_table :sale_settings do |t|
      t.boolean :shipping_cost
      t.boolean :vat
      t.boolean :force_signin
      t.integer :business_id

      t.timestamps null: false
    end
  end
end
