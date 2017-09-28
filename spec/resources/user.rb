require_relative 'avatar_uploader'

class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
end
