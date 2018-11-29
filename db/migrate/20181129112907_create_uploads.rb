class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :uploadable_type
      t.integer :uploadable_id
      t.string :attachment_type

      t.timestamps null: false
    end
  end
end
