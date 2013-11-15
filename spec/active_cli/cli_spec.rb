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
          yielded_instance = nil
          instance         = described_class.new( *arguments(example) ) { |i| yielded_instance = i }

          expect( yielded_instance ).to be instance
        end
      end

      it 'sets arguments instance variable', arguments: [ ] do |example|
        arguments = arguments(example)
        instance  = described_class.new arguments

        expect( instance.instance_variable_get :@arguments ).to be arguments
        expect( instance.arguments                         ).to be arguments
      end

    end
  end
end