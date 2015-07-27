require 'spec_helper'

describe Jibby::Commands::Misc do
  let(:application_double) { double(console: console) }
  let(:console) { Jibby::Console.new }

  describe '::run' do
    subject(:exit) { Jibby::Commands::Misc.exit(application_double) }

    it { is_expected.to eql(false) }
  end

  describe '::clear_screen' do
    subject(:clear_screen) { Jibby::Commands::Misc.clear_screen(application_double) }
    it 'calls clear_screen from the console' do
      expect(console).to receive(:clear_screen)
      clear_screen
    end
  end
end
