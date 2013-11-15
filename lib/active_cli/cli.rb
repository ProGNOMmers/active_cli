require 'active_cli'

module ActiveCLI
  class CLI
    # b .options, .option
    class_attribute :options, instance_accessor: false, instance_predicate: false
    self.options = {}

    def self.option(*args)
      option = Option.new(*args)
      self.options = self.options.merge option.name => option
      option
    end
    # e .options, .option

    attr_reader :arguments

    def initialize(arguments = ARGV)
      @arguments = arguments

      yield self if block_given?
    end
  end
end