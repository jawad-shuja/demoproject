ActiveAdmin.register Order do
  filter :total

  index do
    column :id
    column :total
    column :subtotal
    column :discount

    column :products do |order|
      link_to "See Products (#{order.products.count})", admin_order_products_path(order)
    end

    column :created_at
    column :updated_at

    default_actions
  end

  form do |f|
    f.semantic_errors
    f.inputs :order do
      f.input :total
      f.input :subtotal
      f.input :discount
    end
    f.actions
  end

end
