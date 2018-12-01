class CreateProminents < ActiveRecord::Migration
  def change
    create_table :prominents do |t|
      t.integer :product_id
      t.integer :level
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
