class EventBanner < ActiveRecord::Base
	has_attached_file :file, :styles => { :medium => "500x500" }

	belongs_to :event

end
