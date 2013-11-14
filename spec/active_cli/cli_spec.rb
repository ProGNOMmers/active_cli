require 'spec_helper'

module ActiveCLI
  describe CLI do
    describe '.new' do
      context 'with no arguments' do
        let(:arguments) { [] }
        it 'works' do
          expect { described_class.new *arguments }.to_not raise_error
        end
      end
      context 'with an array argument' do
        let(:arguments) { [ [] ] }
        it 'works' do
          expect { described_class.new *arguments }.to_not raise_error
        end
      end
      context 'with a non-array argument' do
        let(:arguments_list) { [ nil, false, true, 1, Object.new, {} ] }
        it 'raises an ArgumentError' do
          arguments_list.each do |argument|
            expect { described_class.new *[ argument ] }.to raise_error ArgumentError
          end
        end
      end
    end
  end
end