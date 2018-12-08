class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :header_background
      t.string :navtab_color
      t.string :footer_background
      t.string :footer_color
      t.string :body_background_color
      t.string :list_group_item_background
      t.string :list_group_item_color

      t.timestamps null: false
    end
  end
end
