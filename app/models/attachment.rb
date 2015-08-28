class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  has_attached_file :photo,
                    styles: { small: '200x200>' }
  attr_accessible :photo_content_type, :photo_file_name, :photo_file_size, :photo
  validates_attachment_content_type :photo, content_type: ['image/jpeg','image/png']
end
