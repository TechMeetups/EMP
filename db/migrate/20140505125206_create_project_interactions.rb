class CreateProjectInteractions < ActiveRecord::Migration
  def change
    create_table :project_interactions do |t|
      t.integer :project_id
      t.string :project_type
      t.integer :user_id
      t.string :action
      t.text :memo
      t.boolean :status,:default => false

      t.timestamps
    end
  end
end
