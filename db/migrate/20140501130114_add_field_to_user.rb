class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :eventbrite_id, :integer
    add_column :users, :meetup_id, :integer
    add_column :users, :meetup_member_url, :string
    add_column :users, :member_since, :date
    add_column :users, :expertise, :string
    add_column :users, :audience, :string
    add_column :users, :volunteering, :boolean, :default => true
  end
end
