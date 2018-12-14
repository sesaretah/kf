class AddAddressToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :address, :text
  end
end
