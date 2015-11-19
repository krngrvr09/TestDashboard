class AddPaymentStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_status, :boolean
  end
end
