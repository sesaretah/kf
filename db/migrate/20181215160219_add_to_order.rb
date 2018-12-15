class AddToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :reciever_name, :string
    add_column :orders, :reciever_mobile, :string
  end
end
