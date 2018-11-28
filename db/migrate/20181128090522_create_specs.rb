class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.string :title
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
