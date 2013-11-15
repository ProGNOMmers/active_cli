module ActiveCLI
  class CLI

    attr_reader :arguments

    def initialize(arguments = ARGV)
      @arguments = arguments

      yield self if block_given?
    end
  end
end