class ChangeCityDatatype < ActiveRecord::Migration
  def up
  	# change_column :users, :city_id , 'integer USING CAST(city_id AS integer)'
  	change_column :users, :city_id , :integer
  end

  def down
    change_table :users do |t|
      t.change :city_id, :string
    end
  end
end
