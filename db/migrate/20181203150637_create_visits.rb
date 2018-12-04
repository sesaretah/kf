class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitable_id
      t.string :visitable_type
      t.string :visitor_session

      t.timestamps null: false
    end
  end
end
