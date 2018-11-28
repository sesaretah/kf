class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surename
      t.string :phonenumber

      t.timestamps null: false
    end
  end
end
