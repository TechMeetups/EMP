class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :action
      t.text :memo

      t.timestamps
    end
  end
end
