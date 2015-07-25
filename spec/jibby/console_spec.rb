require 'spec_helper'

describe Jibby::Console do
  subject(:new_console) { Jibby::Console.new }

  describe '#clear_screen' do
    subject(:clear_screen) { new_console.clear_screen }
    let(:win) { true }

    before(:each) do
      allow(Gem).to receive(:win_platform?).and_return(win)
    end

    context 'from windows' do
      it 'calls cls on the system' do
        expect_any_instance_of(Object).to receive(:system).with('cls')
        clear_screen
      end
    end

    context 'from non windows' do
      let(:win) { false }

      it 'calls clear on the system' do
        expect_any_instance_of(Object).to receive(:system).with('clear')
        clear_screen
      end
    end
  end

  describe '#silent_prompt' do
    subject(:silent_prompt) { new_console.silent_prompt(prompt_text) }
    let(:prompt_text) { 'foo' }
    let(:input_text) { 'bar' }

    before(:each) do
      expect($stdin).to receive(:noecho).and_return("#{input_text}\n")
      expect(new_console).to receive(:display_label).with(prompt_text)
    end

    it { is_expected.to eql(input_text) }
  end

  describe '#prompt' do
    subject(:prompt) { new_console.prompt(prompt_text) }
    let(:prompt_text) { 'foo' }
    let(:input_text) { 'bar' }

    before(:each) do
      expect($stdin).to receive(:gets).and_return("#{input_text}\n")
      expect_any_instance_of(String).to receive(:display)
    end

    it { is_expected.to eql(input_text) }
  end
end
