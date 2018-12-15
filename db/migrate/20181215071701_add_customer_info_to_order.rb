class AddCustomerInfoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :customer_name, :string
    add_column :orders, :customer_mobile, :string
    add_column :orders, :customer_province, :string
    add_column :orders, :customer_address, :string
    add_column :orders, :customer_postal_code, :string
    add_column :orders, :reciever_province, :string
    add_column :orders, :reciever_address, :string
    add_column :orders, :reciever_postal_code, :string
  end
end
