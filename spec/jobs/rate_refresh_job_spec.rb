require 'rails_helper'

RSpec.describe RateRefreshJob do
  let!(:exchange) do
    Exchange.create(iso_from: :usd,
                    iso_to: :rub,
                    fresh_rate: 66.6666,
                    custom_rate: 62.4242,
                    expires_at: Time.current + 2.day)
  end
  describe '#perform' do
    it 'should should broadcast exchange rate' do
      expect(ActionCable.server).to receive(:broadcast).with('rate', rate: exchange.rate)
      RateRefreshJob.perform_now(exchange)
    end
  end
end
