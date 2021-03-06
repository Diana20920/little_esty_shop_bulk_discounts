class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show]
  def index
    @bulk_discounts = @merchant.bulk_discounts.all
  end

  def show
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
