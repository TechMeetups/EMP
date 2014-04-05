class Event < ActiveRecord::Base
	
	has_many :event_banners
	has_many :event_users
	def can_validate
    	true
  	end
  	
end
