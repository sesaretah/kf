class CreatePixels < ActiveRecord::Migration
  def change
    create_table :pixels do |t|
      t.integer :category_id
      t.string :title

      t.timestamps null: false
    end
  end
end
