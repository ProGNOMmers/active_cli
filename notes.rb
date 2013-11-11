# Opzioni CLI

## Tipi di opzioni

# path: 0 o 1, qualsiasi formato, può essere piazzato dopo un --
# paths: 0 o più, qualsiasi formato, possono stare dopo un --
# proprietà: qualsiasi formato, 

## Esempi

# git version
# git remote add origin url 
# git remote add --tags asd pizza
# git checkout -- /path/to/file
# git --help

# ActiveCLI?

# POSIX like options (ie. tar -zxvf foo.tar.gz)
# GNU like long options (ie. du --human-readable --max-depth=1)
# Java like properties (ie. java -Djava.awt.headless=true -Djava.net.useSystemProxies=true Foo)
# Short options with value attached (ie. gcc -O2 foo.c)
# Windows (ie. ifconfig /all)

CLI

class Help < ActiveCLI::Option
  property
end


GitCLI < ActiveCLI::CLI

  # name, aliases (optional, default: name), options: arguments (default: []), separator (default: ' '), method_name (default: name)
  option( :help                                     ) # git help
  option( :help, 'help'                             ) # git help
  option( :help, [ '-h', '--help' ]                 ) # git -h, git --help
  option( :help, [ :single_hyphen, :double_hyphen ] ) # git -h, git --help
  option( :help, :single_hyphen                     ) # git -h
  option( :help, :double_hyphen                     ) # git -h

  options( help:    nil,
           version: nil,
           log:     [ :single_hyphen, :double_hyphen ] )

  def help
    puts "Usage: ..."
  end

  def version
    puts '1.2.1'
  end

end

GitCLI.new(ARGV) do |cli| # or: GitCLI.new(ARGV)
  begin
    cli.act!
  rescue ActiveCLI::ParseError => e
    $stderr.puts e.error
    cli.help
  end
end

# TODO arg separator