class AddCostToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cost, :integer
  end
end
