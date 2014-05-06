#require 'meetups'
class Event < ActiveRecord::Base
	
	has_many :event_banners, dependent: :destroy
	has_many :event_users, dependent: :destroy
	belongs_to :user
	def can_validate
    	true
  	end
end