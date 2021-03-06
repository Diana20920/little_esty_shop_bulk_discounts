require 'rails_helper'

RSpec.describe 'Create Bulk Discounts' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = @merchant1.bulk_discounts.create!(percent: 10, quantity: 10)
    @discount2 = @merchant1.bulk_discounts.create!(percent: 15, quantity: 20)
    @discount3 = @merchant1.bulk_discounts.create!(percent: 20, quantity: 35)
  end
 it 'I fill in the form with valid data' do
    visit merchant_bulk_discounts_path(@merchant1)
    click_link("New Discount")

    expect(page).to have_content("Create New Bulk Discount")
    expect(page).to have_field(:percent)
    expect(page).to have_field(:quantity)
  end

  it 'Then I am redirected back to the bulk discount index where I see my new bulk discount listed' do
    visit merchant_bulk_discounts_path(@merchant1)
    click_link("New Discount")

    fill_in :percent, with: 50
    fill_in :quantity, with: 150
    click_button("SAVE")

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content("50% off 150 items")
    expect(page).to have_content("New bulk discount has been created!")
  end
end
