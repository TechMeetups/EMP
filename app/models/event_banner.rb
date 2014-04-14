class EventBanner < ActiveRecord::Base
	has_attached_file :file, :styles => { :medium => "500x500" },
				:storage => :s3,
                :bucket => 'tmu-events',
                :s3_credentials =>{
                :access_key_id => 'AKIAIUDOMFJ4ZGYKIO6Q',
                :secret_access_key => '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'
              }

	belongs_to :event

end
