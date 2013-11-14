module ActiveCLI
  class CLI
    def initialize(arguments = [])
      raise ArgumentError, "arguments is not an Array" unless arguments.is_a? Array
    end
  end
end