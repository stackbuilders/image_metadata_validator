require 'active_model'
require "image_metadata_validator/version"

module ActiveModel
  module Validations
    class ImageMetadataValidator < ActiveModel::EachValidator
      CHECKS = {
        greater_than: :>,
        greater_than_or_equal_to: :>=,
        equal_to: :==,
        less_than: :<,
        less_than_or_equal_to: :<=
      }.freeze

      def check_validity!
        options.slice(CHECKS.keys).each do |option, value|
          unless value.is_a?(Numeric) || value.is_a?(Proc) || value.is_a?(Symbol)
            raise ArgumentError, ":#{option} must be a number, a symbol or a proc"
          end
        end
      end

      def validate_each(record, attribute, value)
        dimensions = image_dimensions(value)

        options.each do |key, value|
          unless dimensions[:width].send(CHECKS[key], value)
            record.errors.add(attribute, :metadata)
          end
        end
      end

      private

      def image_dimensions(value)
        Hash[
          [:width, :height].zip(
            MiniMagick::Image.open(value.file.path).dimensions
          )
        ]
      end
    end

    module HelperMethods
      # TODO: Improve comments

      def validates_url(*attr_names)
        validates_with ImageMetadataValidator, _merge_attributes(attr_names)
      end
    end
  end
end
