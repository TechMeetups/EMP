class AddAttachmentFileToProjectBanners < ActiveRecord::Migration
  def self.up
    change_table :project_banners do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :project_banners, :file
  end
end
