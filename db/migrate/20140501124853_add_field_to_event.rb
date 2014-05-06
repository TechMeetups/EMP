class AddFieldToEvent < ActiveRecord::Migration
  def change
    add_column :events, :eventbrite_id, :integer
    add_column :events, :eventbrite_url, :string
  end
end
