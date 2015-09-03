ActiveAdmin.register Review do
  belongs_to :product, parent_class: Product

  index do
    column :id
    column :body
    column :created_at
    column :updated_at

    default_actions
  end
end
