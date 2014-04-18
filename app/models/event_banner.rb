class EventBanner < ActiveRecord::Base
	has_attached_file :file, :styles => { :medium => "500x500" },
				:storage => :s3,
                :bucket =>"tmu-emp",
                :s3_credentials => S3_CREDENTIALS
   	validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/ ,:message => 'Only .jpg/.png/.gif are allowed.'
	belongs_to :event

end
