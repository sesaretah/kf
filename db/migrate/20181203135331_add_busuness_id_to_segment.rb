class AddBusunessIdToSegment < ActiveRecord::Migration
  def change
    add_column :segments, :business_id, :integer
  end
end
