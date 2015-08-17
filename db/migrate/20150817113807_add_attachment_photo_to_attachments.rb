class AddAttachmentPhotoToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_column :attachments, :photo_file_name
    remove_column :attachments, :photo_content_type
    remove_column :attachments, :photo_file_size
    remove_column :attachments, :photo_updated_at
  end
end
