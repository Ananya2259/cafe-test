class AddArchiveToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :archive, :boolean,default: false
  end
end