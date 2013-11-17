require 'active_cli'

module ActiveCLI
  class CLI
    def self.option(*args)
      option = Option.new(*args)
      self.options = self.options.merge option.name => option
      option
    end
  end
end