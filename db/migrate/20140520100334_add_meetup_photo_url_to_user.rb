class AddMeetupPhotoUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :meetup_photo_url, :string
  end
end
