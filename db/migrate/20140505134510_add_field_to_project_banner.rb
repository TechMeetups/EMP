class AddFieldToProjectBanner < ActiveRecord::Migration
  def change
    add_column :project_banners, :event_id, :integer
    add_column :project_banners, :featured, :boolean
  end
end
