class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new, :create, :destroy, :edit, :update]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @bulk_discount = BulkDiscount.new
  end

  def create
    BulkDiscount.create!(percent: params[:percent],
                    quantity: params[:quantity],
                    merchant: @merchant)
    flash.notice = "New bulk discount has been created!"
    redirect_to merchant_bulk_discounts_path(@merchant)
    # else
    #   flash.notice = "Please enter numeric values in order to create your new bulk discount"
    #   render :new
    # end
  end

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.update({
      percent: params[:percent],
      quantity: params[:quantity]})
    bulk_discount.save
    flash.notice = "Your changes have been saved!"
    redirect_to merchant_bulk_discount_path(@merchant, bulk_discount)
  end

  def destroy
    BulkDiscount.destroy(params[:id])
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
