class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
