class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.integer :business_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
