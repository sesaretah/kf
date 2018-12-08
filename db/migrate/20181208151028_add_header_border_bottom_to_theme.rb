class AddHeaderBorderBottomToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :header_border_bottom, :string
  end
end
