class User < ApplicationRecord
  mount_uploader :profile_image, ProfileImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :rooms
  has_many :reservations
end
