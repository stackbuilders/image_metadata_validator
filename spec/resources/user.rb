require_relative 'avatar_uploader'

class User < ActiveRecord::Base
  include ActiveModel::Validations

  mount_uploader :avatar, AvatarUploader
end
