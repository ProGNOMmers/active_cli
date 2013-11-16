require 'active_cli'

module ActiveCLI
  class CLI
    
    # b .options
    def self.converted_options
      {}
    end

    def self.options(options = nil)
      return converted_options unless options

      self.options = options
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

    def self.options=(options)
      method_name = :converted_options

      singleton_class.class_eval do
        remove_possible_method method_name
        options = convert_options options
        define_method(method_name) { options }
      end

      options
    end
    # e .options

    # b .option
    def self.option(*args)
      option = Option.new(*args)
      self.options = self.options.merge option.name => option
      option
    end
    # e .option

    attr_reader :arguments

    def initialize(arguments = ARGV)
      @arguments = arguments

      yield self if block_given?
    end
  end
end