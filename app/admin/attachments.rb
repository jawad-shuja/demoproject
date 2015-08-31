ActiveAdmin.register Attachment do
  belongs_to :product, parent_class: Product

  show do
    attributes_table do
      row 'Image' do |image|
        image_tag(image.photo.url(:small))
      end
      row :id
      row :created_at
      row :updated_at
      row :photo_file_name
      row :photo_content_type
      row :photo_file_size
      row :photo_updated_at
      row :attachable_id
      row :attachable_type
    end
  end
end
