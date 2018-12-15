class CreateTaxations < ActiveRecord::Migration
  def change
    create_table :taxations do |t|
      t.decimal :percent
      t.integer :business_id

      t.timestamps null: false
    end
  end
end
