ActiveAdmin.register Product do
  belongs_to :order, parent_class: Order, optional: true
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

    default_actions
  end
end
