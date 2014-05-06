class CreateMeetupGroups < ActiveRecord::Migration
  def change
    create_table :meetup_groups do |t|

      t.timestamps
    end
  end
end
