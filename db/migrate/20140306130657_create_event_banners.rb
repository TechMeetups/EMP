class CreateEventBanners < ActiveRecord::Migration
  def change
    create_table :event_banners do |t|
      t.integer :event_id
      t.attachment :file
      t.boolean :featured

      t.timestamps
    end
  end
end
