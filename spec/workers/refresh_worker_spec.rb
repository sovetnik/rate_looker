require 'rails_helper'

RSpec.describe RefreshWorker do
  let!(:exchange) do
    Exchange.create(iso_from: :usd,
                    iso_to: :rub,
                    fresh_rate: 66.6666,
                    custom_rate: 62.4242,
                    expires_at: Time.current + 2.day)
  end
  describe '#perform' do
    it 'should set refresh job with first exchange' do
      expect(RateRefreshJob).to receive(:perform_later).with(exchange)
      RefreshWorker.new.perform
    end
  end
end
