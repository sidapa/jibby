require 'spec_helper'
require 'stringio'

describe Jibby::Commands::Misc do
  let(:application_double) { double(interface: interface) }
  let(:interface) { Jibby::Console.new(string_io) }
  let(:string_io) { StringIO.new }

  describe '::run' do
    subject(:exit_command) { Jibby::Commands::Misc.exit(application_double) }

    it 'says goodbye to the user' do
      exit_command
      expect(string_io.string).to eql("bye!\n")
    end

    it { is_expected.to eql(false) }
  end

  describe '::clear_screen' do
    subject(:clear_screen) do
      Jibby::Commands::Misc.clear_screen(application_double)
    end

    it 'calls clear_screen from the interface' do
      expect(interface).to receive(:clear_screen)
      clear_screen
    end
  end
end
