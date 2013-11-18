require 'active_cli'

module ActiveCLI

  class Option

    DEFAULT_MATCHER_PROPERTIES = { prefix: nil, groupable: false }

    def self.default_matcher_properties
      DEFAULT_MATCHER_PROPERTIES
    end

    # name     : option name. It identifies the option; it is used by CLI in order to find the method to execute.
    #
    # matchers : one or more matchers that will be used by CLI in order to match the command argument. It can be:
    #   nil      : sets a matcher inferring the matching component from the option name and applies the default properties
    #   a string : sets a matcher inferring the matching component from itself and applying the default properties
    #   an array : sets a matcher for each value whose matching component is the stringified value and applies the default properties
    #   an hash  : sets a matcher for each occurrence whose matching component is the stringified key and the properties are the default properties merged with the value
    #   :any, :* : catch-all matcher; matches everything
    #
    # matcher properties: an hash of per matcher properties. They are:
    #   prefix : string prefix that will be added to the matching component (f.e. - , -- )
    #   groupable : whether an option is groupable with other options (f.e. -xvzf )
    def initialize(name, matchers = {}, options = {})
      @name, @matchers, @options = name, matchers, options
    end

    def name
      @name.to_s
    end

    def matchers
      case @matchers
      when nil      then { name      => self.class.default_matcher_properties }
      when String   then { @matchers => self.class.default_matcher_properties }
      when Array    then Hash[ @matchers.map { |v| [ v.to_s, self.class.default_matcher_properties ] } ]
      when Hash     then Hash[ @matchers.map { |k, v| [ k.to_s, self.class.default_matcher_properties.merge(v) ] } ]
      when :any, :* then { @matchers => nil }
      end
    end

    def options
      @options
    end

    def ==(other)
      return false unless other.is_a? self.class

      self.name     == other.name     &&
      self.matchers == other.matchers &&
      self.options  == other.options
    end
  end

end