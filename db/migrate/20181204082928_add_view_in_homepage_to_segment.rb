class AddViewInHomepageToSegment < ActiveRecord::Migration
  def change
    add_column :segments, :view_in_homepage, :boolean
  end
end
