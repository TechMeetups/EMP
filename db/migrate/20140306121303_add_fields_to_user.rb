class AddFieldsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :company, :string
  	add_column :users, :user_type, :string
  	add_column :users, :city, :string
  	add_column :users, :address, :string
  	add_column :users, :description, :string
  	add_column :users, :offer, :string
  	add_column :users, :looking_for, :string
  	add_column :users, :twitter, :string
  	add_column :users, :facebook, :string
  	add_column :users, :linkedin, :string
  end
end
