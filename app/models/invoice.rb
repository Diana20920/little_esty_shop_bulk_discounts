class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def find_bulk_discounts
    invoice_items
    .joins(:bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity")
    .select("((invoice_items.quantity * invoice_items.unit_price) * (bulk_discounts.percent/100)) AS discount, invoice_items.*, bulk_discounts.id AS discount_id")
    .order("bulk_discounts.percent desc")
  end

  def total_revenue_with_discount
    total_revenue -  find_bulk_discounts.uniq.sum(&:discount)
  end

  # I need a method for the link next to the invoice_items that can filter whether ii has discounts applied or not.
  # then I can possibly have the link ONLY show if there are discounts applied. 
end
