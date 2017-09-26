require_relative 'avatar_uploader'

class User < ActiveRecord::Base
  include ActiveModel::Validations

  mount_uploader :avatar_greater, AvatarUploader
  mount_uploader :avatar_greater_or_equal, AvatarUploader
  mount_uploader :avatar_equal, AvatarUploader
  mount_uploader :avatar_less, AvatarUploader
  mount_uploader :avatar_less_or_equal, AvatarUploader

  validates :avatar_greater, image_width: { greater_than: 200 }
  validates :avatar_greater_or_equal,
            image_width: { greater_than_or_equal_to: 200 }
  validates :avatar_equal, image_width: { equal_to: 200 }
  validates :avatar_less, image_width: { less_than: 200 }
  validates :avatar_less_or_equal,
            image_width: { less_than_or_equal_to: 200 }
end
