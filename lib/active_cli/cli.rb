module ActiveCLI
  class CLI

    attr_reader :arguments

    def initialize(arguments = ARGV)
      # raise ArgumentError, "arguments is not an Array" unless arguments.is_a? Array

      @arguments = arguments

      yield self if block_given?
    end
  end
end