class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.date :s_date
      t.date :e_date
      t.time :s_time
      t.time :e_time
      t.text :description
      t.string :twitter_hash_tag

      t.timestamps
    end
  end
end
