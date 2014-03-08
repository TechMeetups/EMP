class ChangeDatatypeOfCityInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :city, :integer
  end
end
