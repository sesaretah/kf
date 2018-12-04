class AddLevelToSegment < ActiveRecord::Migration
  def change
    add_column :segments, :level, :integer
  end
end
