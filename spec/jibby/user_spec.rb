require 'spec_helper'

describe Jibby::User do
  subject(:user) do
    Jibby::User.new(data: data)
  end

  let(:data) do
    {
      'key' => 'foo',
      'displayName' => 'Foo User',
      'timeZone' => 'Asia/Manila',
      'active' => is_active
    }
  end

  let(:is_active) { true }

  describe 'attributes' do
    it { expect(user.username).to eql('foo') }
    it { expect(user.fullname).to eql('Foo User') }
    it { expect(user.timezone).to eql('Asia/Manila') }
    it { expect(user.active?).to eql(true) }
  end
end
