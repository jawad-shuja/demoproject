class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :total, precision: 13, scale: 2
      t.decimal :subtotal, precision: 13, scale: 2
      t.decimal :discount
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
