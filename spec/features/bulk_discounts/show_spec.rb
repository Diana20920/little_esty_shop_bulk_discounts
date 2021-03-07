require 'rails_helper'

RSpec.describe 'Show Bulk Discount Info' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = @merchant1.bulk_discounts.create!(percent: 10, quantity: 13)

    visit merchant_bulk_discount_path(@merchant1, @discount1)
  end

  it 'I see the specific bulk discounts quantity threshold and percentage discount' do
    expect(page).to have_content(@discount1.percent)
    expect(page).to have_content(@discount1.quantity)
  end

  it 'Has an Edit link that takes me to a new page with a form to edit the discount' do
    expect(page).to have_link("edit")
    click_link("edit")

    expect(page).to have_content("Edit Bulk Discount")
  end
end
