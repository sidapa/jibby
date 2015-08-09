require 'spec_helper'
require 'stringio'

describe Jibby::Comment do
  subject(:comment) { Jibby::Comment.new(data: data, interface: interface) }

  let(:data) do
    {
      'jibby_index' => 1,
      'author' => { 'displayName' => 'foo_user' },
      'body' => 'test'
    }
  end

  let(:interface) { Jibby::Console.new(string_io) }
  let(:string_io) { StringIO.new }
  before(:each) do
    allow(interface).to receive(:number_of_columns).and_return(5)
  end

  describe '#display_details' do
    it 'should display the details' do
      comment.display_details
      string = "\n=====\nComment #2 Author: foo_user\n=====\ntest\n"
      expect(string_io.string).to eql(string)
    end
  end
end
