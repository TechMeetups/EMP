class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :thumb => "200x200" }

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :offer, :looking_for

end
