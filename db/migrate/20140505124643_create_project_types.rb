class CreateProjectTypes < ActiveRecord::Migration
  def change
    create_table :project_types do |t|

      t.timestamps
    end
  end
end
