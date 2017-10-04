class AvatarUploader < CarrierWave::Uploader::Base
  def extension_whitelist
    %w(jpeg)
  end
end
