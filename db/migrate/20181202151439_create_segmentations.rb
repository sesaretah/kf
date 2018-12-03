class CreateSegmentations < ActiveRecord::Migration
  def change
    create_table :segmentations do |t|
      t.integer :segment_id
      t.integer :product_id
      t.string :ext_code

      t.timestamps null: false
    end
  end
end
