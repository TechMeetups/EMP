class Event < ActiveRecord::Base
after_update :event_update

	has_many :event_banners, dependent: :destroy
	has_many :event_users, dependent: :destroy
	belongs_to :user
	def can_validate
    	true
  	end
  	#Update table without any changes
	def event_update
		self.touch(:updated_at)
	end

end