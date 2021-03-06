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

  describe '#output' do
    subject(:output_text) { new_console.output 'foo' }

    it 'wraps puts' do
      expect { output_text }.to output("foo\n").to_stdout
    end
  end

  describe '#prompt_login' do
    subject(:prompt_login) { new_console.prompt_login }
    let(:username) { 'foo' }
    let(:password) { 'bar' }

    before(:each) do
      expect(new_console).to receive(:prompt).with('Username:')
        .and_return(username)
      expect(new_console).to receive(:silent_prompt).with('Password:')
        .and_return(password)
    end

    it { is_expected.to eql([username, password]) }
  end

  describe '#separator' do
    subject(:separator) { new_console.separator(marker) }
    let(:marker) { '=' }

    it 'should output using the marker' do
      expect_any_instance_of(Object).to receive(:`).with('tput cols')
        .and_return(5)
      expect(new_console).to receive(:output).with('=====')
      separator
    end
  end

  describe '#boxed' do
    it 'calls output based on yielded input' do
      line_1 = 'foo'
      line_2 = 'bar'
      output = []
      output << line_1
      output << line_2

      expect(new_console).to receive(:output).with(output.join("\n"))
      allow_any_instance_of(Object).to receive(:`).with('tput cols')
        .and_return(5)
      allow(new_console).to receive(:separator)

      new_console.boxed do |lines|
        lines << line_1
        lines << line_2
      end
    end
  end
end
