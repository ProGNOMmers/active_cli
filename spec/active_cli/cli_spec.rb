require 'spec_helper'

module ActiveCLI
  describe CLI do
    describe '.new' do
      context 'with no arguments' do
        it 'works' do
          arguments = []
          expect { described_class.new *arguments }.to_not raise_error
        end
      end
      context 'with an array argument' do
        it 'works' do
          arguments = [ [] ]
          expect { described_class.new *arguments }.to_not raise_error
        end
      end
      context 'with a non-array argument' do
        it 'raises an ArgumentError' do
          arguments = [ nil, false, true, 1, Object.new, '', {} ]
          arguments.each do |argument|
            expect { described_class.new *[ argument ] }.to raise_error ArgumentError
          end
        end
      end
      it 'sets arguments instance variable' do
        arguments = [ '--help' ]
        cli = described_class.new arguments
        expect( cli.instance_variable_get :@arguments ).to be arguments
        expect( cli.arguments                         ).to be arguments
      end
    end
  end
end