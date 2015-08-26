class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :coupon
      t.boolean :is_valid

      t.timestamps
    end
    add_index :discounts, :coupon, unique: true
  end
end
