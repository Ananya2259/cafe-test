class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.integer :menu_category_id
      t.string :name
      t.string :description
      t.float :price
    end
  end
end
