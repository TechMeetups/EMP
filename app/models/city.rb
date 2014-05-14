class City < ActiveRecord::Base
	has_many :users, dependent: :destroy
end
def self
	
end