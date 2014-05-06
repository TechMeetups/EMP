class AddNameToProjectType < ActiveRecord::Migration
  def change
    add_column :project_types, :name, :string
  end
end
