require 'rails_helper'

RSpec.describe Exchange, type: :model do
  it { should validate_inclusion_of(:iso_from).in_array(%w(usd)) }
  it { should validate_inclusion_of(:iso_to).in_array(%w(rub)) }
  it do
    should validate_numericality_of(:custom_rate)
      .on(:commit)
  end
  it do
    should validate_numericality_of(:fresh_rate)
      .on(:commit)
  end

  # let(:attributes) { iso_from: 'usd', iso_to: 'rub', fresh_rate: 66.6666  }
  let(:exchange) do
    Exchange.create(iso_from: 'usd',
                    iso_to: 'rub',
                    fresh_rate: 66.6666,
                    custom_rate: 62.42)
  end

  describe '#rate' do
    let(:subject) { exchange.rate }
    context 'when custom value expired or not set' do
      it 'should return value from fresh rate' do
        expect(subject).to eq exchange.fresh_rate
      end
    end
    context 'when custom value is set and not expired' do
      before { exchange.update(custom_rate: 4.20, expires_at: Time.current + 1.hour) }
      it 'should return value from custom rate' do
        expect(subject).to eq exchange.custom_rate
      end
    end
  end

  describe '#refresh_rate!' do
    let(:subject) { exchange.refresh_rate! }
    before do
      allow(exchange).to receive(:fetch_rate).and_return(33.99.to_d)
    end
    it 'should updaste rate with fetched rate' do
      subject
      expect(exchange.fresh_rate).to eq 33.99
    end
    it 'should return fetched rate' do
      expect(subject).to eq 33.99
    end
  end
end
