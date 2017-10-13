module ActiveModel
  module Validations
    module ImageNumericalMetadata
      def check_validity!
        raise ArgumentError, 'Invalid option' unless (options.keys - CHECKS.keys).empty?

        options.slice(*CHECKS.keys).each do |option, value|
          unless value.is_a?(Numeric) || value.is_a?(Proc) || value.is_a?(Symbol)
            raise ArgumentError, ":#{option} must be a number, a symbol or a proc"
          end
        end
      end

      private

      CHECKS = {
        greater_than: :>,
        greater_than_or_equal_to: :>=,
        equal_to: :==,
        less_than: :<,
        less_than_or_equal_to: :<=
      }.freeze

      def validate_dimension(record, attribute, value, dimension)
        if value.file.present?
          dimension_value = image_dimensions(value)[dimension]

          options.each do |k, v|
            unless dimension_value.public_send(CHECKS[k], v)
              record.errors.add(attribute, error_key(dimension))
            end
          end
        end
      end

      def error_key(dimension)
        :"image_metadata_#{dimension}"
      end

      def image_dimensions(value)
        [:width, :height]
          .zip(MiniMagick::Image.open(value.file.path).dimensions)
          .to_h
      end
    end
  end
end
