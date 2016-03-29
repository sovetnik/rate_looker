require 'rails_helper'

feature 'Update Rate' do
  given!(:exchange) do
    Exchange.create(
      iso_from: :usd,
      iso_to: :rub,
      fresh_rate: 72.80
    )
  end

  scenario 'visitor can update rate' do
    visit '/'
    click_on 'admin'
    expect(page).to have_content('Custom rate')
    fill_in 'Custom rate', with: '69.69'
    page.find('#exchange_expires_at_1i').select '2016'
    page.find('#exchange_expires_at_2i').select 'April'
    page.find('#exchange_expires_at_3i').select '12'
    page.find('#exchange_expires_at_4i').select '23'
    page.find('#exchange_expires_at_5i').select '59'
    click_on 'update rate'
    expect(page.find('.rate')).to have_content(69.69)
  end

  scenario 'visitor can rate errors if send wrong data' do
    visit '/'
    click_on 'admin'
    expect(page).to have_content('Custom rate')
    fill_in 'Custom rate', with: 'forty two'
    page.find('#exchange_expires_at_1i').select '2016'
    page.find('#exchange_expires_at_2i').select 'April'
    page.find('#exchange_expires_at_3i').select '12'
    page.find('#exchange_expires_at_4i').select '23'
    page.find('#exchange_expires_at_5i').select '59'
    click_on 'update rate'
    expect(page.find('.help-block')).to have_content('is not a number')
  end
end
