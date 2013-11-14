module ActiveCLI
  class CLI

    attr_reader :arguments

    def initialize(arguments = [])
      raise ArgumentError, "arguments is not an Array" unless arguments.is_a? Array

      @arguments = arguments
    end
  end
end