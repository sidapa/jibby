require 'spec_helper'

describe Jibby::Commands::Misc do
  describe '::run' do
    subject(:exit) { Jibby::Commands::Misc.exit(application_double) }
    let(:application_double) { double(console: console) }
    let(:console) { Jibby::Console.new }

    it { is_expected.to eql(false) }
  end
end
