module ActiveModel
  module Validations
    class ImageNumericalMetadataValidator

      def self.create_width_validator(checks, options)
        new(:width, checks, options)
      end

      def self.create_height_validator(checks, options)
        new(:height, checks, options)
      end

      def validate_dimension(record, attribute, value)
        if value.file.present?
          dimension_value = image_dimensions(value)[@dimension]

          @options.each do |k, v|
            unless dimension_value.public_send(@checks[k], v)
              record.errors.add(attribute, error_key)
            end
          end
        end
      end

      private

      def initialize(dimension, checks, options)
        @dimension = dimension
        @checks = checks
        @options = options
      end

      def error_key
        :"image_metadata_#{@dimension}"
      end

      def image_dimensions(value)
        [:width, :height]
          .zip(MiniMagick::Image.open(value.file.path).dimensions)
          .to_h
      end
    end
  end
end
