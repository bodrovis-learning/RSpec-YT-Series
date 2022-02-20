# frozen_string_literal: true

RSpec.describe ExchangeIt::User do
  let(:user) { |ex| described_class.new(ex.metadata[:name] || 'John', 'Doe') }

  it 'returns name' do
    expect(user.name).to eq('John')
    expect(user.name).to be_an_instance_of(String)
  end

  it 'returns name as a string', name: nil do
    expect(user.name).to be_an_instance_of(String)
  end

  it 'returns surname' do
    expect(user.surname).to eq('Doe')
  end

  specify '#account' do
    expect(user.account).to be_an_instance_of(ExchangeIt::Account)
  end

  it 'has zero balance by default' do
    expect(user.balance).to eq(0)
  end
end
