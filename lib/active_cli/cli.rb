require 'active_cli'

module ActiveCLI
  class CLI
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