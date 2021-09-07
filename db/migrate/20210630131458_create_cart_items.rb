class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :user_id
      t.integer :menu_item_id
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
