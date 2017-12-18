class User < ActiveRecord::Base
 has_many :posts
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable ,:confirmable

   mount_uploader :photo, PhotoUploader


end
