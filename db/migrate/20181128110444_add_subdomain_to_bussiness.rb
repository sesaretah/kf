class AddSubdomainToBussiness < ActiveRecord::Migration
  def change
    add_column :businesses, :subdomain, :string
  end
end
