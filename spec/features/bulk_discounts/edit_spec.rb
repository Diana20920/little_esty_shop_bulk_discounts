require 'rails_helper'

RSpec.describe 'Edit Bulk Discount' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = @merchant1.bulk_discounts.create!(percent: 10, quantity: 13)

    visit merchant_bulk_discount_path(@merchant1, @discount1)
    click_link("edit")
  end

  it 'And I see that the discounts current attributes are pre-poluated in the form' do
    expect(find_field(:percent).value).to eq("#{@discount1.percent}")
    expect(find_field(:quantity).value).to eq("#{@discount1.quantity}")
  end

  it 'I change any/all of the information, click submit, I am redirected to the bulk discount show page where I see the updated attributes' do
    fill_in :percent, with: 65
    fill_in :quantity, with: 1000
    click_button("SAVE")

    expect(page).to have_content("Your changes have been saved!")
    expect(page).to have_content("Percentage Discount is 65")
    expect(page).to have_content("Quantity Threshold is 1000")
  end
end
