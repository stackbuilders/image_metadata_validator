require 'active_model'
require_relative 'numerical_metadata_checks'
require_relative 'image_numerical_metadata_validator'

module ActiveModel
  module Validations
    class ImageHeightValidator < EachValidator
      include NumericalMetadataChecks

      def validate_each(record, attribute, value)
        validator = ImageNumericalMetadataValidator.create_height_validator(CHECKS, options)
        validator.validate_dimension(record, attribute, value)
      end
    end

    module HelperMethods
      # Validates whether the height of an specified carrierewave image is valid.
      #
      #   class User
      #     include ActiveModel::Validations
      #
      #     mount_uploader :avatar, AvatarUploader
      #     validates_height :avatar, { greater_than: 500 }
      #   end
      # * <tt>:greater_than</tt> If set, verifies image height is greater than the provided number.
      # * <tt>:greater_than_or_equal_to</tt> If set, verifies image height is greater than or equals to the provided number.
      # * <tt>:equal_to</tt> If set, verifies image height is equal to the provided number.
      # * <tt>:less_than</tt> If set, verifies image height is less than the provided number.
      # * <tt>:less_than_or_equal_to</tt> If set, verifies image height is less than or equals to the provided number.

      def validates_image_height(*attr_names)
        validates_with ImageHeightValidator, _merge_attributes(attr_names)
      end
    end
  end
end
