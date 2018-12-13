class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :subtotal
      t.string :tax
      t.string :shipping
      t.string :total
      t.integer :business_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
