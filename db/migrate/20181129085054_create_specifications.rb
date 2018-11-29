class CreateSpecifications < ActiveRecord::Migration
  def change
    create_table :specifications do |t|
      t.integer :product_id
      t.integer :spec_id
      t.string :spec_value

      t.timestamps null: false
    end
  end
end
