class CreateUserToItems < ActiveRecord::Migration
  def change
    create_table :user_to_items do |t|
      t.integer :user_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
