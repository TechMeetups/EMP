class CreateMeetupResources < ActiveRecord::Migration
  def change
    create_table :meetup_resources do |t|

      t.timestamps
    end
  end
end
