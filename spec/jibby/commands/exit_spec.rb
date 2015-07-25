require 'spec_helper'

describe Jibby::Commands::Exit do
  describe '::run' do
    subject(:run) { Jibby::Commands::Exit.run(application_double) }
    let(:application_double) { double(console: console) }
    let(:console) { Jibby::Console.new }

    it { is_expected.to eql(false) }
  end
end
