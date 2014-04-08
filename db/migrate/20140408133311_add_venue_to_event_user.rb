class AddVenueToEventUser < ActiveRecord::Migration
  def change
    add_column :event_users, :venue, :string
  end
end
