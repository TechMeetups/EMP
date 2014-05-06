class ChangeEventbriteIdInEvent < ActiveRecord::Migration
  def up
   change_column :events, :eventbrite_id, :bigint 
  
  end

  def down
   change_column :events, :eventbrite_id, :integer 
  
  end
end
