class CreateProjectBanners < ActiveRecord::Migration
  def change
    create_table :project_banners do |t|

      t.timestamps
    end
  end
end
