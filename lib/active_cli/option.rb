require 'active_cli'

module ActiveCLI

  class Option

    attr_reader :name

    def initialize(*args)
      options = args.extract_options!

      @name = args[0]
    end

    def ==(other)
      return false unless other.is_a? self.class
      self.name == other.name
    end
  end

end