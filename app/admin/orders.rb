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

    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), resource_path(resource), class: "member_link view_link"
      links
    end
  end
end
