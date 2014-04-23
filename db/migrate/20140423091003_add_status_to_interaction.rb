class AddStatusToInteraction < ActiveRecord::Migration
  def change
    add_column :interactions, :status, :boolean ,:default => false
  end
end
