require 'spec_helper'

describe Jibby do
  let(:host) { 'http://foo.bar' }

  it 'has a version number' do
    expect(Jibby::VERSION).not_to be nil
  end

  describe '::start' do
    let(:application_double) { double }

    it 'calls start on a new instance of console' do
      expect(Jibby::Application).to receive(:new).and_return(application_double)
      expect(application_double).to receive(:start)

      Jibby.start(host)
    end
  end
end
