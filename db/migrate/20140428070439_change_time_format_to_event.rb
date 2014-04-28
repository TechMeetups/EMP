class ChangeTimeFormatToEvent < ActiveRecord::Migration
   def up
   change_column :events, :s_time, :string
   change_column :events, :e_time, :string
  end

  def down
   change_column :events, :s_time, :time
   change_column :events, :e_time, :time
  end
  s
end
