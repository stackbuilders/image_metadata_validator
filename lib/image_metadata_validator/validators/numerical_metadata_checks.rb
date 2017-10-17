module ActiveModel
  module Validations
    module NumericalMetadataChecks
      CHECKS = {
        greater_than: :>,
        greater_than_or_equal_to: :>=,
        equal_to: :==,
        less_than: :<,
        less_than_or_equal_to: :<=
      }.freeze
      private_constant :CHECKS

      def check_validity!
        raise ArgumentError, 'Invalid option' unless (options.keys - CHECKS.keys).empty?

        options.slice(*CHECKS.keys).each do |option, value|
          unless value.is_a?(Numeric) || value.is_a?(Proc) || value.is_a?(Symbol)
            raise ArgumentError, ":#{option} must be a number, a symbol or a proc"
          end
        end
      end
    end
  end
end
