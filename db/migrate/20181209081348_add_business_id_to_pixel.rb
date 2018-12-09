class AddBusinessIdToPixel < ActiveRecord::Migration
  def change
    add_column :pixels, :business_id, :integer
  end
end
