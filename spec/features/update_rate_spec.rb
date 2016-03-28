require 'rails_helper'

feature 'Update Rate' do
  given!(:exchange) do
    Exchange.create(iso_from: :usd,
                    iso_to: :rub,
                    custom_rate: 72.80,
                    expires_at: Time.current + 1.minute)
  end

  scenario 'visitor can see rate page on /' do
    visit '/'
    click_on 'admin'
    expect(page).to have_content('Custom rate')
    fill_in 'Custom rate', with: '69.69'
    click_on 'update rate'
    expect(page.find('.rate')).to have_content(69.69)
  end
end
