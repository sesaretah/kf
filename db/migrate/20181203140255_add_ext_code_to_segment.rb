class AddExtCodeToSegment < ActiveRecord::Migration
  def change
    add_column :segments, :ext_code, :string
  end
end
