class Project < ActiveRecord::Base

	has_many :project_banners, dependent: :destroy
	has_many :project_users, dependent: :destroy
	belongs_to :user
	def can_validate
    	true
  	end
end
