require 'rails_helper'

feature 'Show Rate' do
  given!(:exchange) do
    Exchange.create(iso_from: :usd,
                    iso_to: :rub,
                    fresh_rate: 66.6666,
                    custom_rate: 62.4242,
                    expires_at: Time.current + 2.day)
  end

  scenario 'visitor can see rate page on /' do
    visit '/'
    expect(page).to have_content('USD/RUB exchange rate')
    expect(page.find('.rate')).to have_content(62.4242)
  end
end
