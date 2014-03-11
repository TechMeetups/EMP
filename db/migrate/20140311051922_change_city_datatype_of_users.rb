class ChangeCityDatatypeOfUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :city, :city_id
  	change_column :users, :city_id, :integer
  end
end
