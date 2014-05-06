class ChangeFieldNameToProjectBanner < ActiveRecord::Migration
  def change
  	rename_column :project_banners, :event_id, :project_id
  end
end
