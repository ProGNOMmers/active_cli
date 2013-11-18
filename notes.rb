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

  # Trova l'opzione / metodo giusto e lo esegue
  def act_option(option_name)
  end

  # Parsa le opzioni, valida, se la validazione non passa lancia un'eccezione, se passa esegue
  def act!
  end

  # Parsa le opzioni, valida, se la validazione non passa ritorna false, se passa esegue
  def act
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


CatCLI < ActiveCLI::CLI
  option :show_all                  , { 'A'                => { prefix: '-',  groupable: true  } ,
                                        'show-all'         => { prefix: '--', groupable: false } }

  option :number_nonblank           , { 'b'                => { prefix: '-',  groupable: true  } ,
                                        'number-nonblank'  => { prefix: '--', groupable: false } }

  option :show_nonprinting_and_ends , { 'e'                => { prefix: '-',  groupable: true  } }

  option :show_ends                 , { 'E'                => { prefix: '-',  groupable: true  } ,
                                        'show-ends'        => { prefix: '--', groupable: false } }

  option :number                    , { 'n'                => { prefix: '-',  groupable: true  } ,
                                        'number'           => { prefix: '--', groupable: false } }

  option :squeeze_blank             , { 's'                => { prefix: '-',  groupable: true  } ,
                                        'squeeze-blank'    => { prefix: '--', groupable: false } }

  option :show_nonprinting_and_tabs , { 't'                => { prefix: '-',  groupable: true  } }

  option :show_tabs                 , { 'T'                => { prefix: '-',  groupable: true  } ,
                                        'show-tabs'        => { prefix: '--', groupable: false } }

  option :ignored                   , { 'u'                => { prefix: '-',  groupable: true  } }

  option :show_nonprinting          , { 'v'                => { prefix: '-',  groupable: true  } ,
                                        'show-nonprinting' => { prefix: '--', groupable: false } }

  option :help                      , { 'help'             => { prefix: '--', groupable: false } }

  option :version                   , { 'version'          => { prefix: '--', groupable: false } }

  option :stdin                     , { '-'                => { prefix: '',   groupable: false } }

  option :paths                     , :any                                                       , { arity: -1 }
end

TarCLI < ActiveCLI::CLI
  option :read_archive,     '-', type: :stdin

  option :concatenate , {   'A'                 => { prefix: '',   groupable: true  } ,
                            'A'                 => { prefix: '-',  groupable: true  } ,
                            'catenate'          => { prefix: '--', groupable: false } ,
                            'concatenate'       => { prefix: '--', groupable: false } }

  option :create      , {   'c'                 => { prefix: '',   groupable: true  } ,
                            'c'                 => { prefix: '-',  groupable: true  } ,
                            'create'            => { prefix: '--', groupable: false } }

  option :diff        , {   'd'                 => { prefix: '',   groupable: true  } ,
                            'd'                 => { prefix: '-',  groupable: true  } ,
                          [ 'diff', 'compare' ] => { prefix: '--', groupable: false } }

  option :delete      , {   'delete'            => { prefix: '--', groupable: false } }

  option :append      , {   'r'                 => { prefix: '',   groupable: true  } ,
                            'r'                 => { prefix: '-',  groupable: true  } ,
                            'append'            => { prefix: '--', groupable: false } }

  option :append      , {   't'                 => { prefix: '',   groupable: true  } ,
                            't'                 => { prefix: '-',  groupable: true  } ,
                            'list'              => { prefix: '--', groupable: false } }

  option :test_label  ,     '--test-label'

  option :update      , {   'u'                 => { prefix: '',   groupable: true  } ,
                            'u'                 => { prefix: '-',  groupable: true  } ,
                            'update'            => { prefix: '--', groupable: false } }

  option :extract     , {   'x'                 => { prefix: '',   groupable: true  } ,
                            'x'                 => { prefix: '-',  groupable: true  } ,
                          [ 'get', 'extract' ]  => { prefix: '--', groupable: false } }
end