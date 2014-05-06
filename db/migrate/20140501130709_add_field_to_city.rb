class AddFieldToCity < ActiveRecord::Migration
  def change
    add_column :cities, :city_meetup_url, :string
  end
end
