class AddFieldToProject < ActiveRecord::Migration
  def change
    add_column :projects, :user_id, :integer
    add_column :projects, :title, :string
    add_column :projects, :s_date, :date
    add_column :projects, :e_date, :date
    add_column :projects, :description, :string
    add_column :projects, :twitter_hash_tag, :string
  end
end
