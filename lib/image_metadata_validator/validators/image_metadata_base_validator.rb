require 'active_model'

module ActiveModel
  module Validations
    class ImageMetadataBaseValidator < ActiveModel::EachValidator
      CHECKS = {
        greater_than: :>,
        greater_than_or_equal_to: :>=,
        equal_to: :==,
        less_than: :<,
        less_than_or_equal_to: :<=
      }.freeze

      def check_validity!
        raise ArgumentError, 'Invalid option' unless (options.keys - CHECKS.keys).empty?

        options.slice(*CHECKS.keys).each do |option, value|
          unless value.is_a?(Numeric) || value.is_a?(Proc) || value.is_a?(Symbol)
            raise ArgumentError, ":#{option} must be a number, a symbol or a proc"
          end
        end
      end

      def validate_each(record, attribute, value)
        if value.file.present?
          dimension = dimension_to_validate(value)

          options.each do |k, v|
            unless dimension.send(CHECKS[k], v)
              record.errors.add(attribute, dimension_key)
            end
          end
        end
      end

      private

      def dimension_to_validate(value)
        image_dimensions(value)[dimension_key]
      end

      def dimension_key
        raise NotImplementedError,
          'This is an abstract validator. Use width or height validators instead.'
      end

      def image_dimensions(value)
        [:width, :height]
          .zip(MiniMagick::Image.open(value.file.path).dimensions)
          .to_h
      end
    end
  end
end
