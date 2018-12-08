class AddThemeIdToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :theme_id, :integer
  end
end
