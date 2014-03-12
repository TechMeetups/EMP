class Event < ActiveRecord::Base
	belongs_to :city
	has_many :event_banners
	has_many :event_users
end
