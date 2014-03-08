class CreateEventUsers < ActiveRecord::Migration
  def change
    create_table :event_users do |t|
      t.integer :event_id
      t.string :event_type

      t.timestamps
    end
  end
end
