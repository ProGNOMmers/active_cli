require 'active_cli'

module ActiveCLI
  class CLI

    CONVERTED_OPTIONS_METHOD_NAME = :converted_options

    class_eval <<-"RUBY"
      def self.#{CONVERTED_OPTIONS_METHOD_NAME}
        {}
      end
    RUBY

    def self.options(options = nil)
      return converted_options unless options

      self.options = options
    end

    def self.options=(options)
      singleton_class.class_eval do
        remove_possible_method CONVERTED_OPTIONS_METHOD_NAME
        options = convert_options options
        define_method(CONVERTED_OPTIONS_METHOD_NAME) { options }
      end

      options
    end

    singleton_class.class_eval do
      def self.convert_options(options)
        Hash[ options.map { |k, v| [ k, convert_option(k, v) ] } ]
      end

      def self.convert_option(key, object)
        return object if object.is_a? Option

        Option.new *Array.wrap(object || key)
      end
    end
  end
end