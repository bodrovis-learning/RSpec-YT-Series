# frozen_string_literal: true

RSpec.describe ExchangeIt::Utils::Uid do
  let(:dummy) { Class.new { include ExchangeIt::Utils::Uid }.new }

  describe '#hash' do
    it 'returns nil when no args were given' do
      expect(dummy.hash).to be_nil
    end

    it 'returns string when at least 1 arg was given' do
      expect(dummy.hash('str', 'str2')).to be_an_instance_of(String)
    end
  end
end
