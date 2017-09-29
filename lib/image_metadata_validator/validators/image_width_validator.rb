require 'active_model'
require_relative 'image_metadata_base_validator'

module ActiveModel
  module Validations
    class ImageWidthValidator < ImageMetadataBaseValidator
      private

      def dimension_to_validate(value)
        image_dimensions(value)[:width]
      end
    end

    module HelperMethods
      # TODO: Improve comments

      def validates_image_width(*attr_names)
        validates_with ImageWidthValidator, _merge_attributes(attr_names)
      end
    end
  end
end
