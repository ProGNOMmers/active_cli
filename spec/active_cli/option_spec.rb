require 'spec_helper'

module ActiveCLI
  describe Option do
    describe '#name' do
      it 'returns the name, eventually stringifying it' do
        expect( described_class.new( 'help' ).name ).to eq 'help'
        expect( described_class.new( :help  ).name ).to eq 'help'
      end
    end
    describe '#matchers' do
      context 'when the instance initialization matchers argument is' do
        context 'nil' do
          it 'sets a matcher inferring the matching component from the option name and applies the default properties' do
            expect( described_class.new( :help, nil ).matchers ).to eq( 'help' => described_class.default_matcher_properties )
          end
        end
        context 'a string' do
          it 'sets a matcher inferring the matching component from itself and applies the default properties' do
            expect( described_class.new( :help, 'usage' ).matchers ).to eq( 'usage' => described_class.default_matcher_properties )
          end
        end
        context 'an array' do
          it 'sets a matcher for each occurrence whose matching component is the stringified occurrence and applies the default properties' do
            expect( described_class.new( :help, 'usage' ).matchers ).to eq( 'usage' => described_class.default_matcher_properties )
          end
        end
        context 'an hash' do
          it 'sets a matcher for each occurrence whose matching component is the stringified key and the properties are the default properties merged with the value' do
            expect( described_class.new( :help, 'usage' ).matchers ).to eq( 'usage' => described_class.default_matcher_properties )
          end
        end
        context ':any, :*' do
          it 'sets a matcher for each occurrence whose matching component is the stringified key and the properties are the default properties merged with the value' do
            expect( described_class.new( :help, 'usage' ).matchers ).to eq( 'usage' => described_class.default_matcher_properties )
          end
        end
      end
    end

    describe '#==' do
      context 'when compared to an object which is an instance of the same class' do
        context 'with the same name, matchers and options' do
          it 'is true' do
            one   = described_class.new :help, [ '--help' ], { arity: 0 }
            other = described_class.new :help, [ '--help' ], { arity: 0 }

            expect( one ).to eq other
          end
        end
        context 'with the same matchers and options and different name' do
          it 'is false' do
            one   = described_class.new :help,    [ '--help' ], { arity: 0 }
            other = described_class.new :version, [ '--help' ], { arity: 0 }

            expect( one ).not_to eq other
          end
        end
        context 'with the same name and options and different matchers' do
          it 'is false' do
            one   = described_class.new :help, [ '--help' ],    { arity: 0 }
            other = described_class.new :help, [ '--version' ], { arity: 0 }

            expect( one ).not_to eq other
          end
        end
        context 'with the same name and matchers and different options' do
          it 'is false' do
            one   = described_class.new :help, [ '--help' ], { arity: 0 }
            other = described_class.new :help, [ '--help' ], { arity: 10 }

            expect( one ).not_to eq other
          end
        end
      end
      context 'when compared to an object which is an instance of another class' do
        it 'is false' do
          one   = described_class.new :help, [ '--help' ], { arity: 0 }
          other = "I'm not a #{described_class} instance"

          expect( one ).not_to eq other
        end
      end
    end
  end
end