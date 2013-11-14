require 'spec_helper'

module ActiveCLI
  describe CLI do
    describe '.new' do

      def arguments(example)
        example.metadata[:arguments]
      end

      context 'with no arguments', arguments: [ ] do
        it 'works' do |example|
          expect { described_class.new *arguments(example) }.to_not raise_error
        end
      end

      context 'with an array argument', arguments: [ [] ] do
        it 'works' do |example|
          expect { described_class.new *arguments(example) }.to_not raise_error
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

      it 'sets arguments instance variable', arguments: [ ] do |example|
        arguments = arguments(example)
        cli       = described_class.new arguments

        expect( cli.instance_variable_get :@arguments ).to be arguments
        expect( cli.arguments                         ).to be arguments
      end

    end
  end
end