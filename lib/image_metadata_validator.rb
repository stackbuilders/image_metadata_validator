require 'active_model'
require 'image_metadata_validator/version'
require 'image_metadata_validator/validators/image_width_validator'
require 'image_metadata_validator/validators/image_height_validator'
require 'active_support/i18n'
I18n.load_path += Dir[File.dirname(__FILE__) + "/locale/*.yml"]
