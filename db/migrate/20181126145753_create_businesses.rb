class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :title
      t.integer :user_id
      t.string :tel
      t.string :mobile
      t.string :fax
      t.text :address
      t.text :bio
      t.string :telegram_channel
      t.string :instagram_page
      t.string :email

      t.timestamps null: false
    end
  end
end
