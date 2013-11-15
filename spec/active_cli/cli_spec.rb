require 'spec_helper'

module ActiveCLI
  describe CLI do
    describe '.new' do

      def arguments(example)
        example.metadata[:arguments]
      end

      # context 'with invalid arguments' do
      #   it 'raises an ArgumentError', arguments_list: [ nil, false, true, 1, Object.new, '', {} ] do |example|
      #     example.metadata[:arguments_list].each do |argument|
      #       expect { described_class.new *[ argument ] }.to raise_error ArgumentError
      #     end
      #   end
      # end

      # context 'with valid arguments' do
        context 'with no arguments', arguments: [ ] do
          it 'works' do |example|
            expect { described_class.new *arguments(example) }.to_not raise_error
          end
          it 'sets .arguments to ARGV' do |example|
            expect( described_class.new( *arguments(example) ).arguments ).to be ARGV
          end
        end

        context 'with an array argument', arguments: [ [] ] do
          it 'works' do |example|
            expect { described_class.new *arguments(example) }.to_not raise_error
          end
        end

        context 'giving a block with one argument', arguments: [ ] do
          it 'yields self' do |example|
            # TODO it doesn't check for `self` identity; I don't know how to implement it
            expect { |b| described_class.new *arguments(example), &b }.to yield_with_args described_class
          end
        end

        it 'sets arguments instance variable', arguments: [ ] do |example|
          arguments = arguments(example)
          instance  = described_class.new arguments

          expect( instance.instance_variable_get :@arguments ).to be arguments
          expect( instance.arguments                         ).to be arguments
        end
      # end

    end
  end
end