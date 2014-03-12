class AddReqUserIdToEventUsers < ActiveRecord::Migration
  def change
  	add_column :event_users, :user_id , :integer
  end
end
