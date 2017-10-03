require 'active_model'
require_relative 'image_metadata_base_validator'

module ActiveModel
  module Validations
    class ImageWidthValidator < ImageMetadataBaseValidator
      private

      def dimension_key
        :width
      end
    end

    module HelperMethods
      # Validates whether the width of an specified carrierewave image is valid.
      #
      #   class User
      #     include ActiveModel::Validations
      #
      #     mount_uploader :avatar, AvatarUploader
      #     validates_width :avatar, { greater_than: 500 }
      #   end
      # * <tt>:greater_than</tt> If set, verifies image width is greater than the provided number.
      # * <tt>:greater_than_or_equal_to</tt> If set, verifies image width is greater than or equals to the provided number.
      # * <tt>:equal_to</tt> If set, verifies image width is equal to the provided number.
      # * <tt>:less_than</tt> If set, verifies image width is less than the provided number.
      # * <tt>:less_than_or_equal_to</tt> If set, verifies image width is less than or equals to the provided number.

      def validates_image_width(*attr_names)
        validates_with ImageWidthValidator, _merge_attributes(attr_names)
      end
    end
  end
end