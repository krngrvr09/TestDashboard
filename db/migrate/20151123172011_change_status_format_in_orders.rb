class ChangeStatusFormatInOrders < ActiveRecord::Migration
  def up
    change_column :orders, :status, :boolean
  end

  def down
    change_column :orders, :status, :string
  end
end
