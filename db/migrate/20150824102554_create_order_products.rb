class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.references :order
      t.references :product

      t.timestamps
    end
    add_index :order_products, :order_id
    add_index :order_products, :product_id
  end
end
