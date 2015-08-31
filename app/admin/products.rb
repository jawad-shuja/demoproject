ActiveAdmin.register Product do
  belongs_to :order, parent_class: Order
  filter :title
  filter :body
  filter :price

  index do
    column :id
    column :title
    column :body
    column :price
    column :created_at
    column :updated_at

    column :reviews do |product|
      link_to "See Reviews (#{product.reviews.count})", admin_product_reviews_path(product)
    end

    column :attachments do |product|
      link_to "See Attachments (#{product.attachments.count})", admin_product_attachments_path(product)
    end

    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end
end
