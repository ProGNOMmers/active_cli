require 'spec_helper'

module ActiveCLI
  describe CLI do

    let(:subclass) { Class.new described_class }

    describe '#initialize' do
      def arguments(example)
        example.metadata[:arguments]
      end

      context 'with no arguments', arguments: [ ] do
        it 'works' do |example|
          expect { described_class.new *arguments(example) }.not_to raise_error
        end
        it 'sets .arguments to ARGV' do |example|
          expect( described_class.new( *arguments(example) ).arguments ).to be ARGV
        end
      end

      context 'with an array argument', arguments: [ [] ] do
        it 'works' do |example|
          expect { described_class.new *arguments(example) }.not_to raise_error
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

    describe '.options' do
      it 'is initialized with an empty hash' do
        expect( subclass.options ).to eq( {} )
      end

      it 'accepts an hash argument' do
        expect{ subclass.options( {} ) }.not_to raise_error
      end

      context 'with a raw options hash as argument' do
        it 'sets .options to an Option instances hash obtained from the argument', argument: { help: ['help'], version: ['version'] } do |example|
          subclass.options( example.metadata[:argument] )
          expect( subclass.options ).to eq( { help: Option.new('help'), version: Option.new('version') } )
        end

        context 'with the hash values empty' do
          it 'sets .options to an Option instances hash obtained from the argument', argument: { help: nil, version: nil } do |example|
            subclass.options( example.metadata[:argument] )
            expect( subclass.options ).to eq( { help: Option.new(:help), version: Option.new(:version) } )
          end
        end
      end

      context 'with a raw options array pairs as argument' do
        it 'sets .options to an Option instances hash obtained from the argument', argument: [ [:help, ['help'] ], [:version, ['version'] ] ] do |example|
          subclass.options( example.metadata[:argument] )
          expect( subclass.options ).to eq( { help: Option.new('help'), version: Option.new('version') } )
        end

        context 'with the second array value empty' do
          it 'sets .options to an Option instances hash obtained from the argument', argument: [:help, :version] do |example|
            subclass.options( example.metadata[:argument] )
            expect( subclass.options ).to eq( { help: Option.new(:help), version: Option.new(:version) } )
          end
        end
      end
    end

    describe '.option' do
      let!(:option_name) { :help }

      context 'when .options does not include an option with the same name' do
        it 'stores a new ActiveCLI::Option instance to .options' do
          expect { subclass.option option_name }.to change { subclass.options.size }.from(0).to(1)
        end

        it 'makes the option accessible via .options[option_name]' do
          subclass.option option_name
          expect( subclass.options[option_name] ).to eq Option.new option_name
        end
      end

      context 'when .options includes an option with the same name' do
        it 'replaces the old option with the new one' do
          old_option = subclass.option(option_name)
          new_option = subclass.option(option_name)

          option = subclass.options[option_name]

          expect( option ).not_to be old_option
          expect( option ).to be new_option
        end
      end

      it 'protects the parent class from getting .options dirty by the subclass' do
        subclass.option option_name

        expect( subclass.options ).not_to eq described_class.options
      end
    end

  end
end