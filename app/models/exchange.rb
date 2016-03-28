require 'money/bank/google_currency'

class Exchange < ApplicationRecord
  validates :iso_from, inclusion: { in: %w(usd) }
  validates :iso_to, inclusion: { in: %w(rub) }

  after_update :broadcast_rate!

  def rate
    expired? ? fresh_rate! : custom_rate
  end

  def refresh_rate!
    update!(fresh_rate: fetch_rate)
    fetch_rate
  end

  def expired?
    expires_at.nil? || expires_at < Time.current
  end

  private

  def fresh_rate!
    fresh_rate ? fresh_rate : refresh_rate!
  end

  def fetch_rate
    bank.get_rate(iso_from, iso_to).to_f
  end

  def bank
    Money::Bank::GoogleCurrency.new
  end

  def broadcast_rate!
    ActionCable.server.broadcast 'rate', rate: rate
  end
end
