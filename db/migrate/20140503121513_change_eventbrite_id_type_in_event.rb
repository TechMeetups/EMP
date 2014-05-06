class ChangeEventbriteIdTypeInEvent < ActiveRecord::Migration
  def up
   change_column :events, :eventbrite_id, :bigint ,:limit =>8
  
  end

  def down
   change_column :events, :eventbrite_id, :integer 
  
  end
end
