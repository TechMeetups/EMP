class CreateMeetupUsers < ActiveRecord::Migration
  def change
    create_table :meetup_users do |t|

      t.timestamps
    end
  end
end
