require 'rails_helper'

RSpec.describe 'bulk discounts' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = @merchant.create!(percent: 10, quantity: 10)
binding.pry
  end
end
