class CreateOrderToItems < ActiveRecord::Migration
  def change
    create_table :order_to_items do |t|
      t.integer :order_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
