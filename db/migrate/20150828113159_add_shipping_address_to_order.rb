class AddShippingAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address, :text, null: false
  end
end
