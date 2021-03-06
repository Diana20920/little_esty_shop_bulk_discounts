require 'rails_helper'

RSpec.describe 'bulk discounts' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = @merchant1.bulk_discounts.create!(percent: 10, quantity: 10)
    @discount2 = @merchant1.bulk_discounts.create!(percent: 15, quantity: 20)
    @discount3 = @merchant1.bulk_discounts.create!(percent: 20, quantity: 35)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it 'shows bulk discounts percentage discount and quantity thresholds' do

    within("#discount-#{@discount1.id}") do
      expect(page).to have_content("#{@discount1.percent}")
      expect(page).to have_content("#{@discount1.quantity}")
    end
    within("#discount-#{@discount2.id}") do
      expect(page).to have_content("#{@discount2.percent}")
      expect(page).to have_content("#{@discount2.quantity}")
    end
    within("#discount-#{@discount3.id}") do
      expect(page).to have_content("#{@discount3.percent}")
      expect(page).to have_content("#{@discount3.quantity}")
    end
  end

  it 'each bulk discount listed includes a link to its show page' do

    within("#discount-#{@discount1.id}") do
      expect(page).to have_link("#{@discount1.percent}% off #{@discount1.quantity} items")
    end
    within("#discount-#{@discount2.id}") do
      expect(page).to have_link("#{@discount2.percent}% off #{@discount2.quantity} items")
    end
    within("#discount-#{@discount3.id}") do
      expect(page).to have_link("#{@discount3.percent}% off #{@discount3.quantity} items")
    end

    click_link("#{@discount1.percent}% off #{@discount1.quantity} items")

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
  end

  it 'I see a link to create a new discount' do
    expect(page).to have_link("New Discount")
  end

  it 'When I click New Discount, I am taken to a form in a new page to add a new bulk discount' do
    click_link("New Discount")
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
  end

  it 'Then next to each bulk discount I see a link to delete it' do
    within("#discount-#{@discount1.id}") do
      expect(page).to have_button("delete")
    end
    within("#discount-#{@discount2.id}") do
      expect(page).to have_button("delete")
    end
    within("#discount-#{@discount3.id}") do
      expect(page).to have_button("delete")
    end
  end

  it 'I click the Delete link and I am redirected back to the bulk discounts index page where I no longer see the discount' do
    within("#discount-#{@discount2.id}") do
      expect(page).to have_button("delete")
      click_button("delete")
    end
    expect(page).to_not have_link("#{@discount2.percent}% off #{@discount2.quantity} items")
  end

  it 'I see a section with a header of Upcoming Holidays' do
    expect(page).to have_content("Upcoming Holidays")
  end
end
# In this section the name and date of the next 3 upcoming US holidays are listed.
