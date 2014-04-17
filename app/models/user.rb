class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :thumb => "300x300" },
                :storage => :s3,
                :bucket => 'tmu-events',
                :s3_credentials =>{
                :access_key_id => 'AKIAIUDOMFJ4ZGYKIO6Q',
                :secret_access_key => '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'
              }
   validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/ ,:message => ', Only Image files are allowed.'
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :offer, :looking_for

  has_many :events, dependent: :destroy
  has_many :interactions, dependent: :destroy
  has_many :event_users , dependent: :destroy
  belongs_to :city
end
