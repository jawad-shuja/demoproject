class AddAttachableToAttachment < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.references :attachable, polymorphic: true, index: true
    end
  end

  def self.down
    remove_column :attachments, :attachable_id
    remove_column :attachments, :attachable_type
  end
end
