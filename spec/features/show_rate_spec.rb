require 'rails_helper'

feature 'Show Rate' do
  given!(:exchange) do
    Exchange.create(iso_from: :usd,
                    iso_to: :rub,
                    custom_rate: 72.80,
                    expires_at: Time.current + 1.minute)
  end

  scenario 'visitor can see rate page on /' do
    visit '/'
    expect(page).to have_content('USD/RUB exchange rate')
    expect(page.find('.rate')).to have_content(72.80)
  end
end
