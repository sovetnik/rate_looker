require 'money/bank/google_currency'

class Exchange < ApplicationRecord
  validates :iso_from, inclusion: { in: %w(usd) }
  validates :iso_to, inclusion: { in: %w(rub) }

  def rate
    expired? ? fresh_rate : custom_rate
  end

  def refresh_rate
    update(fresh_rate: fetch_rate)
  end

  private

  def fetch_rate
    bank.get_rate(iso_from, iso_to).to_f
  end

  def bank
    Money::Bank::GoogleCurrency.new
  end

  def expired?
    expires_at.nil? || expires_at < Time.current
  end
end
